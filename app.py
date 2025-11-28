from flask import Flask, render_template
import psycopg2
import os

app = Flask(__name__)

# Database connection settings
DB_NAME = os.getenv("DB_NAME", "movierec")
DB_USER = os.getenv("DB_USER", "carolina")  # change if your PG username is different
DB_PASSWORD = os.getenv("DB_PASSWORD", "")  # set via env var if you use a password
DB_HOST = os.getenv("DB_HOST", "/tmp")      # matches your PGHOST for class
DB_PORT = os.getenv("DB_PORT", "8888")      # matches your PGPORT for class


def get_db_connection():
    conn = psycopg2.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
    )
    return conn


@app.route("/")
def index():
    """Home page: show some movies from the database."""
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT m_id, m_title, m_releaseYear, m_rating
        FROM tables.movie
        ORDER BY m_title;
    """)
    movies = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("index.html", movies=movies)


if __name__ == "__main__":
    app.run(debug=True)
