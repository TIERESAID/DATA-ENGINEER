# Columns to be copied
customer_research_selected = ['date_id', 'geo_id', 'sales_qty', 'sales_amt']
user_activity_log_selected = ['date_time', 'customer_id']
user_log_selected = ['date_time', 'customer_id','quantity','payment_amount']

# Function to insert data into PostgreSQL table with specific columns
def insert_data_to_postgres(schema, table_name, csv_path, selected_columns):
    conn = None
    try:
        conn = psycopg2.connect(**db_params)
        cursor = conn.cursor()

        # Read CSV file into a pandas DataFrame
        df = pd.read_csv(csv_path)

        # Select only the specified columns
        df_selected = df[selected_columns]

        # Create a StringIO buffer to write CSV data
        csv_buffer = StringIO()
        df_selected.to_csv(csv_buffer, index=False, header=False, sep=',')  # Assuming tab-separated values

        # Move the buffer cursor to the beginning of the buffer
        csv_buffer.seek(0)

        # Build the SQL query with COPY command
        copy_sql = f"COPY {schema}.{table_name} ({', '.join(selected_columns)}) FROM stdin WITH CSV HEADER DELIMITER as ','"

        # Execute copy_expert to efficiently copy data into PostgreSQL table
        cursor.copy_expert(sql=copy_sql, file=csv_buffer)

        conn.commit()
    except Exception as e:
        print(f"Error: {e}")
    finally:
        if conn is not None:
            conn.close()