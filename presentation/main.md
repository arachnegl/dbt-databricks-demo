# DBT for Data Platform Management

## Introduction to DBT

- Who am I?
- Who are you?
 - data engineers
 - data managers

------------

Not working for DBT Labs.
Soft engineer. very experienced with Python and a lot of SQL experience.
I am not a DBT pro. But I have dug around in the src.
Two DBT projects to date.
real believer in combo of SQL + DBT.

## DBT in Action 

My case studies:
- Fund Management
- Logistics company

Key Achievements:
- portability (here with PostgreSQL and DuckDB)
- tech implementation patterns clearly defined and standardised.
- non tech stakeholders appreciated the diagrams.

-------------

read online for DBT & other's case studies.
Orchestration with Airflow.

## What is Data Build Tool aka DBT?

A tool for transformations. The T in ETL (or ELT).
Brings software engineering best practices to SQL projects (more later).
Portability through concept of Adapters means one tool many (SQL) computes eg. Databricks, PostgreSQL, SQLServer, Snowflake...
It is batch oriented.
SQL focussed.
DBT core is Open Source - no licensing costs, a vibrant community...

------------

Fishtown analytics, data consultancy.
Apparently there is some recent support for streaming on certain platforms: eg Materialize
Python pandas support does exist (recent) and others may come.
This is really a SQL tool in my eyes.
Some adapters are more equal than others. Not all features are allways supported.
https://docs.getdbt.com/docs/supported-data-platforms

## Sofware Enginering Best Practices

Brings software engineering best practice to SQL projects.

Modularity: Building Blocks of SQL
Reusability: Writing Once, Using Everywhere
Standardization: Keeping SQL Code Clean
Testability: Write SQL tests using `dbt-core` and `dbt-expectations`

local dev experience also works well with integrating it with CI/CD.

-------------

The dbt-expectations depends on packages.

## The dependency graph (DAG)

Constructs a dependency graph (DAG).
Dependencies between tables and views are explicit in code (yaml + macros). 
Validation at compile time - saves dev round trip.
Documenation benefits (will revisit later).

A standardised workflow for the Common Data Model (or medallion architecture)

-------------
DAGs - Terraform, Airflow.
enhanced dev experience

## Lineage & Visualizing Data Flow

`dbt docs` code generated documentation.
Tracking Changes and Dependencies

```bash
dbt docs generate
dbt docs serve
```

-------------

dbt docs are generated directly from source code ensuring docs are never outdated.
https://hub.getdbt.com/

## Technologies involved

DBT compiles Jinja templates to SQL.
The templates define an execution graph (a DAG).
DBT then orchestrates the execution of that graph.

Four: SQL, yaml, Jinja, python.

These are transformed (compiled) to SQL that is then executed.

As DBT projects live in a file system these can be version controlled (git).

-------------

Starts with SQL and yaml.
python library pip install

## Concept Overview

Configurations:
- profile.yml (usually stored at `~/.dbt/profiles.yml`)
- dbt_project.yml

Business Logic:
- source
- seeds
- models
- macros

## model - minimal example

jinja macros: `config` and `ref`

```
-- src: models/table_a.sql
{{ config(materialized='table') }} -- jinja

with source_data as (
    select 1 as id
    union all
    select null as id
)

select *
from source_data
where id is not null

```

```
-- src: models/table_b.sql
select *
from {{ ref('table_a') }} -- jinja macro `ref` creates dependency
where id = 1
```

```yaml
# src: models/schema.yml
models:
  - name: table_a
    columns:
      - name: id
  - name: table_b
    columns:
      - name: id

```

## model jaffle shop example

```
-- src: models/staging/jaffle_shop/stg_jaffle_shop_customers.sql
with source_customers as (
    select * from {{ source('jaffle_shop', 'customers') }}
),

renamed_customers as (
    select
        id as customer_id,
        first_name,
        last_name
    from source_customers
)

select * from renamed_customers
```

```yaml
# src: models/staging/jaffle_shop/stg_jaffle_shop.yml
version: 2

models:
  - name: stg_jaffle_shop_customers
    columns:
      - name: customer_id
        tests:
          - unique
          - not_null
```


## Migrating existing SQL

Reuse of existing SQL code bases is immediately possible.
Incremental rewrite migrating existing code bases without knowing templating. 
With stored procedures close to lift and shift.

-------------
I have never done this but I know others who have.
py (pandas)  -> only if you have a substantial existing code base in pandas.
Think of any problems? talk to me.
Learning curve of DBT constucts (eg resource paths, + prefix)
Can't organise your projects by having different schemas
Project files Vs property files.
Problems with table name limits of backend (PostgreSQL) for tmp tables.

## Summary

- SQL with software engineering best practices (version control, tests...)
- documentation & lineage (`dbt docs`)
- rich modern workflow (local dev, DataOps, quick iterations...)
- open source (no licensing, vast community...)

## Q&A
