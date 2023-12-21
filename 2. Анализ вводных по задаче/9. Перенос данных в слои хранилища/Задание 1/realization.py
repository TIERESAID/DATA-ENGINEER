def copy_data_to_postgres(schema, table_name, csv_path):
    conn = psycopg2.connect(**db_params)
    cursor = conn.cursor()

    # Read CSV file into a pandas DataFrame
    df = pd.read_csv(csv_path)

    # Create a StringIO buffer to write CSV data
    csv_buffer = StringIO()
    df.to_csv(csv_buffer, index=False, header=False, sep=',')  # Assuming tab-separated values

    # Move the buffer cursor to the beginning of the buffer
    csv_buffer.seek(0)

    # Build the SQL query with COPY command
    copy_sql = f"COPY {schema}.{table_name} FROM stdin WITH CSV HEADER DELIMITER as ','"

    # Execute copy_expert to efficiently copy data into PostgreSQL table
    cursor.copy_expert(sql=copy_sql, file=csv_buffer)


    conn.commit()
    conn.close()

    # Load data into PostgreSQL tables in the "stage" schema
copy_data_to_postgres('stage', 'customer_research', csv_paths['customer_research'])
copy_data_to_postgres('stage', 'user_order_log', csv_paths['user_order_log'])
copy_data_to_postgres('stage', 'user_activity_log', csv_paths['user_activity_log'])