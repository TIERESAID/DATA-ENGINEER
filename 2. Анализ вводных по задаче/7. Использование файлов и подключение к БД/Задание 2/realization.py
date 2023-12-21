# Define SQL queries to create tables with appropriate data types
import psycopg2

create_customer_research_table_query = """
CREATE TABLE IF NOT EXISTS stage.customer_research (
    date_id             TIMESTAMP,
    category_id         BIGINT,
    geo_id              BIGINT,
    sales_qty           BIGINT,
    sales_amt           BIGINT
);
"""

create_user_order_log_table_query = """
CREATE TABLE IF NOT EXISTS stage.user_order_log (
    id               BIGINT,
    uniq_id           VARCHAR,
    date_time         TIMESTAMP,
    city_id           BIGINT,
    city_name         VARCHAR(100),
    customer_id       BIGINT,
    first_name        VARCHAR(100),
    last_name         VARCHAR(100),
    item_id           BIGINT,
    item_name         VARCHAR(100),
    quantity          BIGINT,
    payment_amount    BIGINT
);
"""

create_user_activity_log_table_query = """
CREATE TABLE IF NOT EXISTS stage.user_activity_log (
    id              BIGINT,
    uniq_id         VARCHAR,
    date_time       TIMESTAMP,
    action_id       BIGINT,
    customer_id     BIGINT,
    quantity        BIGINT
);
"""

try:
    conn = psycopg2.connect(
        host="localhost",
        port='15432',
        database="de",
        user="jovyan",
        password="jovyan"
    )
    cursor = conn.cursor()

    # Begin the transaction
    cursor.execute("BEGIN;")

    # Execute the queries
    cursor.execute(create_customer_research_table_query)
    cursor.execute(create_user_order_log_table_query)
    cursor.execute(create_user_activity_log_table_query)
    # Commit the transaction
    conn.commit()

except Exception as e:
    # Handle exceptions and log errors
    print(f"Error: {e}")
    conn.rollback()

finally:
    # Close the cursor and connection
    cursor.close()
    conn.close()
