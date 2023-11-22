# dbt + Databricks Demo!

This is intended to demo dbt on Databricks running in Azure.

## presentation

[The presentation can be found here](presentation/main.md)

## local setup

Ensure you have Azure cli installed for bicep.

A databricks platform can be created and destroyed with the following:

```bash
make deploy
make destroy
```

Install python requirements:

```bash
make install_requirements

```

copy and then modify your dbt profiles file.
```bash
$ cp ./sample.profiles.yml ~/.dbt/profiles.yml
```

Populate `~/.dbt/profiles.yml` with your Databricks host, API token, cluster ID, and schema name. These will be available from the above `make deploy` step.

validate your setup:

```bash
dbt debug
```

## execute

```bash
dbt seed
dbt run
dbt test
```

## Notes on seed data

### dbt seeds

Downloaded with:
```bash
aws s3 cp s3://dbt-tutorial-public/jaffle_shop_orders.csv    seeds/jaffle_shop_orders.csv
aws s3 cp s3://dbt-tutorial-public/jaffle_shop_customers.csv seeds/jaffle_shop_customers.csv
aws s3 cp s3://dbt-tutorial-public/stripe_payments.csv       seeds/stripe_payments.csv
```

### manaul setup of data.

These would then be used as DBT as a source.

Create Databricks tables `jaffle_shop.orders`, `jaffle_shop.customers`,
and `stripe.payments` from these CSV files.

Now create the tables using the databricks notebook.

(Took 1.66 mins on my cluster.)

```
%sql

DROP SCHEMA IF EXISTS jaffle_shop CASCADE;
CREATE SCHEMA jaffle_shop;

CREATE TABLE jaffle_shop.orders
USING csv
OPTIONS (
  path "s3://dbt-tutorial-public/jaffle_shop_orders.csv",
  header "true",
  inferSchema "true"
);

CREATE TABLE jaffle_shop.customers
USING csv
OPTIONS (
  path "s3://dbt-tutorial-public/jaffle_shop_customers.csv",
  header "true",
  inferSchema "true"
);

DROP SCHEMA IF EXISTS stripe CASCADE;
CREATE SCHEMA stripe;

CREATE TABLE stripe.payments
USING csv
OPTIONS (
  path "s3://dbt-tutorial-public/stripe_payments.csv",
  header "true",
  inferSchema "true"
);

```


## Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
- Watch our [Office Hours](https://www.youtube.com/watch?v=C9WgnKEnwmg) on dbt + Spark
