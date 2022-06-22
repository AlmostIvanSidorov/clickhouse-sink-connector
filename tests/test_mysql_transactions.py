import time
import unittest
from datetime import date

from clickhouse_connection import ClickHouseConnection
from mysql_connection import MySqlConnection
from fake_data import FakeData

class MyTestCase(unittest.TestCase):

    conn = None

    @classmethod
    def setUpClass(cls):
        print("Setup class")


    @classmethod
    def tearDownClass(cls):
        print("Teardown class")


    def test_mysql_transactions_insert(self):

        #time.sleep(20)

        conn = MySqlConnection()
        conn.create_connection()


        table_name = 'products'

        col_names = conn.get_column_names(f'select * from {table_name} limit 1')
        sql_query = conn.get_insert_sql_query(table_name,','.join(col_names), len(col_names))

        # Start transaction. auto_commit is set to true
        conn.get_connection().start_transaction();

        fake_row_1 = FakeData.get_fake_products_row()
        fake_row_2 = FakeData.get_fake_products_row()

        conn.execute_sql(sql_query, fake_row_1)
        conn.execute_sql(sql_query, fake_row_2)

        print(conn.execute_sql(f'select count(productCode) from {table_name}'))
        conn.get_connection().close()
        print(conn.execute_sql(f'select count(productCode) from {table_name}'))


if __name__ == '__main__':
    unittest.main()
