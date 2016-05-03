from bokeh.charts import Bar, output_file, show, hplot
import psycopg2, psycopg2.extras
import pandas as pd
import sys

x = sys.argv[1]
mod = sys.argv[2]
limit = sys.argv[3]

try:
    conn = psycopg2.connect("dbname='cta' user='ArtSiriwatt' host='localhost' password=''")
except:
    print "I am unable to connect to the database"
cur = conn.cursor()
try:
	c = "SELECT "+x+", COUNT("+x+") FROM cta_stops GROUP BY "+x+" ORDER BY COUNT("+x+") "+mod+" LIMIT "+limit+";"
	cur.execute(c)
except:
    print "Query Failed"

rows = cur.fetchall()
df = pd.DataFrame.from_records(rows, columns=[x, 'count_'+x])

p = Bar(df, x, values='count_'+x, title="Graph")
output_file("bar.html")
show(p)