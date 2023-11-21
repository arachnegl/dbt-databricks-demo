# dbt + Databricks Demo!

This is a modified version of our public [tutorial](https://docs.getdbt.com/tutorial/setting-up)
intended for users of dbt on Databricks.

## python requirements

```
pip install dbt-core
pip install dbt-spark
pip install dbt-databricks

```

## Sample data

Create Databricks tables `jaffle_shop.orders`, `jaffle_shop.customers`,
and `stripe.payments` from these CSV files.

Located in a public S3 bucket ([docs](https://docs.databricks.com/data/tables.html#create-a-table-using-the-ui)):

Original locations:

```
s3://dbt-tutorial-public/jaffle_shop_orders.csv
s3://dbt-tutorial-public/jaffle_shop_customers.csv
s3://dbt-tutorial-public/stripe_payments.csv
```

Downloaded with:
```bash
aws s3 cp s3://dbt-tutorial-public/jaffle_shop_orders.csv jaffle_shop_orders.csv
aws s3 cp s3://dbt-tutorial-public/jaffle_shop_customers.csv jaffle_shop_customers.csv
aws s3 cp s3://dbt-tutorial-public/stripe_payments.csv stripe_payments.csv
```

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

## Getting started

The instructions below assume you are running dbt on macOS. Linux and Windows 
users should adjust the bash commands accordingly.

1. Clone this github repo
2. Install [dbt-spark](https://github.com/fishtown-analytics/dbt-spark): `pip install dbt-spark`
3. Copy the example profile to your `~/.dbt` folder (created when installing dbt):
```bash
$ cp ./sample.profiles.yml ~/.dbt/profiles.yml
```
4. Populate `~/.dbt/profiles.yml` with your Databricks host, API token, cluster ID, and schema name
```bash
open ~/.dbt
```
5. Verify that you can connect to Databricks
```
$ dbt debug
```
6. Verify that you can run dbt
```
$ dbt run
```

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
- Watch our [Office Hours](https://www.youtube.com/watch?v=C9WgnKEnwmg) on dbt + Spark
