from bokeh.charts import Bar, output_file, output_server, show, hplot
from bokeh.io import output_file, show, vform
from bokeh.models.widgets import Slider, Button, Select
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
output_server("bar.html")


select = Select(title="Max or Min:", value="ASC", options=["ASC", "DESC"])
slider = Slider(start=0, end=100, value=1, step=1, title="Number of Elements")
button = Button(label="Submit", type="success")
layout = vform(select, slider, button)


show(layout)
