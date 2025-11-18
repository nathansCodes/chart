use std::path::{Path, PathBuf};

use anyhow::Context;
use charming::{
    Chart, ImageRenderer,
    component::Title,
    element::{Label, LabelPosition, TextAlign},
    series::{Tree, TreeLayout, TreeNode},
};
use clap::{Parser, Subcommand};
use postgres::{Client, NoTls};

fn create(client: &mut Client) -> anyhow::Result<()> {
    client.batch_execute(
        "
        drop table if exists Person_Rolle;
        drop table if exists Rolle;
        drop table if exists Person;
        create table Rolle (
            R_ID serial primary key,
            R_Bezeichnung varchar(255)
        );

        create table Person (
            P_ID serial primary key,
            P_Vorname varchar(255),
            P_Nachname varchar(255)
        );

        create table Person_Rolle (
            PR_ID serial primary key,
            PR_Person_ID int references Person(P_ID),
            PR_Rolle_ID int references Rolle(R_ID),
            PR_Eintritt date,
            PR_Austritt date,
            PR_Vorgesetzter int references Person_Rolle(PR_ID)
        );
        ",
    )?;

    Ok(())
}

fn insert(client: &mut Client, replace: bool) -> anyhow::Result<()> {
    if replace {
        client.batch_execute(
            "
            drop table Person_Rolle;
            drop table Person;
            drop table Rolle;
        ",
        )?;

        create(client)?;
    }

    client.batch_execute(
        "
        insert into Rolle (R_Bezeichnung)
        values
            ('Generalinspekteur'),
            ('Major'),
            ('Leutnant'),
            ('Unteroffizier');
        ",
    )?;

    client.batch_execute(
        "
        insert into Person (P_Vorname, P_Nachname)
        values
            ('Mark', 'Graf'),
            ('Hubert-Peter', 'Neinberger'),
            ('Helmut', 'Krastavac'),
            ('Kristoph', 'Dreimauer'),
            ('Susanne', 'Gerster'),
            ('Josef', 'Siegbert'),
            ('Rudolph', 'Wilfried'),
            ('Alfred', 'Niklaus'),
            ('Samuel', 'Boettinger'),
            ('Marwin', 'Edeltraud'),
            ('Brigitte', 'Hannah'),
            ('Dietrich', 'Tiedemann'),
            ('Annelise', 'Meinhard'),
            ('Lara', 'Sigrid'),
            ('Tilman', 'Edeltraud'),
            ('Martin', 'Irmengard');
        ",
    )?;

    client.batch_execute(
        "
        insert into Person_Rolle (PR_Person_ID, PR_Rolle_ID, PR_Eintritt, PR_Austritt, PR_Vorgesetzter)
        values
            (1, 1, date('2003-08-08'), null, null),
            (2, 2, date('2011-02-27'), null, 1),
            (3, 3, date('2016-11-03'), null, 2),
            (4, 4, date('2023-04-17'), null, 3),
            (5, 2, date('2023-04-17'), null, 1),
            (6, 4, date('2023-04-17'), null, 7),
            (7, 3, date('2023-04-17'), null, 5),
            (8, 4, date('2023-04-17'), null, 7),
            (9, 4, date('2023-04-17'), null, 3),
            (10, 3, date('2023-04-17'), null, 2),
            (11, 3, date('2023-04-17'), null, 5),
            (12, 4, date('2023-04-17'), null, 10),
            (13, 4, date('2023-04-17'), null, 10),
            (14, 4, date('2023-04-17'), null, 11),
            (15, 4, date('2023-04-17'), null, 11);
        ",
    )?;

    Ok(())
}

fn get_node(client: &mut Client, id: i32) -> anyhow::Result<TreeNode> {
    let row = client.query_one(
        &format!(
            "select * from person_rolle
            inner join person
            on person_rolle.pr_person_id = person.p_id
            inner join rolle
            on person_rolle.pr_rolle_id = rolle.r_id
            where person_rolle.pr_id = {};",
            id
        ),
        &[],
    )?;

    let children = client
        .query(
            &format!(
                "select * from person_rolle
                inner join person
                on person_rolle.pr_person_id = person.p_id
                inner join rolle
                on person_rolle.pr_rolle_id = rolle.r_id
                where person_rolle.pr_vorgesetzter = {};",
                id
            ),
            &[],
        )
        .unwrap_or_default();

    let children_nodes = children
        .iter()
        .filter_map(|row| get_node(client, row.get("pr_id")).ok())
        .collect::<Vec<_>>();

    Ok(TreeNode {
        name: format!(
            "{}\n{} {}",
            row.get::<&str, &str>("r_bezeichnung"),
            row.get::<&str, &str>("p_vorname"),
            row.get::<&str, &str>("p_nachname"),
        )
        .into(),
        value: None,
        collapsed: Some(false),
        children: Some(children_nodes),
    })
}

fn generate(client: &mut Client, path: &Path) -> anyhow::Result<()> {
    let data = get_node(client, 1)?;

    let chart = Chart::new()
        .title(
            Title::new()
                .text("Deutsche Bundeswehr")
                .top("1%")
                .left("50%")
                .text_align(TextAlign::Center),
        )
        .series(
            Tree::new()
                .layout(TreeLayout::Orthogonal)
                .symbol_size(15.0)
                .label(Label::new().position(LabelPosition::Bottom).font_size(15.0))
                .data(vec![data]),
        );

    let renderer = ImageRenderer::new(1920, 1080);
    renderer
        .theme(charming::theme::Theme::Dark)
        .save(&chart, path)?;

    Ok(())
}

#[derive(Parser)]
struct Args {
    #[command(subcommand)]
    subcommand: Commands,
    #[arg(short, long)]
    env: Option<PathBuf>,
}

#[derive(Subcommand)]
enum Commands {
    Create,
    Insert {
        #[arg(short, long)]
        replace: bool,
    },
    Generate {
        #[arg(short, long)]
        output: Option<PathBuf>,
    },
}

fn main() -> anyhow::Result<()> {
    let args = Args::parse();

    let env = std::fs::read_to_string(args.env.unwrap_or(PathBuf::from("./.env")))
        .context(".env file couldn't be found.")?;

    let mut client = Client::connect(&env, NoTls)?;

    match args.subcommand {
        Commands::Create => create(&mut client)?,
        Commands::Insert { replace } => insert(&mut client, replace)?,
        Commands::Generate { output } => {
            generate(&mut client, &output.unwrap_or(PathBuf::from("./chart.svg")))?
        }
    }

    client.close()?;

    Ok(())
}
