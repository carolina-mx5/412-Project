#imports
from flask import Flask, render_template, request
import psycopg2
import os

app = Flask(__name__)

# Database connection settings
DB_NAME = os.getenv("DB_NAME", "movierec")
DB_USER = os.getenv("DB_USER", "carolina")  
DB_PASSWORD = os.getenv("DB_PASSWORD", "")  
DB_HOST = os.getenv("DB_HOST", "/tmp")     
DB_PORT = os.getenv("DB_PORT", "8888")      


def get_db_connection():
    #db connections
    return psycopg2.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
    )


@app.route("/", methods=["GET", "POST"])
def index():
    """
    Single page:
      - Search by Genre -> movies & shows in that genre
      - Search by Actor -> movies & shows with that actor
      - Search by Rating -> movies & shows in a rating range
    """
    conn = get_db_connection()
    cur = conn.cursor()

    # Genres for first dropdown
    cur.execute("""
        SELECT g_id, g_name
        FROM tables.genre
        ORDER BY g_name;
    """)
    genres = cur.fetchall()   # list of (g_id, g_name)

    # Actors for second dropdown 
    cur.execute("""
        SELECT a_id, a_firstname, a_lastname
        FROM tables.actor
        ORDER BY a_lastname, a_firstname;
    """)
    actors = cur.fetchall()   # list of (a_id, a_firstname, a_lastname)

    # Variables used for template
    # Genre section
    movies_by_genre = []
    shows_by_genre = []
    selected_genre_id = None
    selected_genre_name = None

    # Actor section
    movies_by_actor = []
    shows_by_actor = []
    selected_actor_id = None
    selected_actor_name = None

    # Rating section
    movies_by_rating = []
    shows_by_rating = []
    selected_min_rating = None
    selected_max_rating = None

    if request.method == "POST":
        # Figures out which form was submitted
        if "submit_genre" in request.form:
            # genre form 
            selected_genre_id = request.form.get("genre_id")

            if selected_genre_id:
                # Movies linked to selected genre
                cur.execute("""
                    SELECT m.m_id,
                           m.m_title,
                           m.m_releaseYear,
                           m.m_rating
                    FROM tables.movie AS m
                    JOIN tables.hasmoviegenre AS h
                      ON m.m_id = h.m_id
                    WHERE h.g_id = %s
                    ORDER BY m.m_title;
                """, (selected_genre_id,))
                movies_by_genre = cur.fetchall()

                # Shows linked to selected genre
                cur.execute("""
                    SELECT s.s_id,
                           s.s_title,
                           s.s_releaseYear,
                           s.s_duration,
                           s.s_rating
                    FROM tables.show AS s
                    JOIN tables.hasshowgenre AS h
                      ON s.s_id = h.s_id
                    WHERE h.g_id = %s
                    ORDER BY s.s_title;
                """, (selected_genre_id,))
                shows_by_genre = cur.fetchall()

                # Gets genre name for heading
                cur.execute("""
                    SELECT g_name
                    FROM tables.genre
                    WHERE g_id = %s;
                """, (selected_genre_id,))
                row = cur.fetchone()
                if row:
                    selected_genre_name = row[0]

        elif "submit_actor" in request.form:
            # actor form 
            selected_actor_id = request.form.get("actor_id")

            if selected_actor_id:
                # Gets actor name for heading
                cur.execute("""
                    SELECT a_firstname, a_lastname
                    FROM tables.actor
                    WHERE a_id = %s;
                """, (selected_actor_id,))
                row = cur.fetchone()
                if row:
                    selected_actor_name = f"{row[0]} {row[1]}"

                # Movies w/ this actor
                cur.execute("""
                    SELECT DISTINCT m.m_id,
                                    m.m_title,
                                    m.m_releaseYear,
                                    m.m_rating
                    FROM tables.movie AS m
                    JOIN tables.acted_in AS ai
                      ON m.m_id = ai.m_id
                    WHERE ai.a_id = %s
                    ORDER BY m.m_title;
                """, (selected_actor_id,))
                movies_by_actor = cur.fetchall()

                # Shows w/ this actor
                cur.execute("""
                    SELECT DISTINCT s.s_id,
                                    s.s_title,
                                    s.s_releaseYear,
                                    s.s_duration,
                                    s.s_rating
                    FROM tables.show AS s
                    JOIN tables.acted_in AS ai
                      ON s.s_id = ai.s_id
                    WHERE ai.a_id = %s
                    ORDER BY s.s_title;
                """, (selected_actor_id,))
                shows_by_actor = cur.fetchall()

        elif "submit_rating" in request.form:
            # rating form 
            selected_min_rating = request.form.get("min_rating")
            selected_max_rating = request.form.get("max_rating")

            if selected_min_rating and selected_max_rating:
                # Movies that have rating between min and max values
                cur.execute("""
                    SELECT m.m_id,
                           m.m_title,
                           m.m_releaseYear,
                           m.m_rating
                    FROM tables.movie AS m
                    WHERE m.m_rating::numeric BETWEEN %s AND %s
                    ORDER BY m.m_rating::numeric DESC, m.m_title;
                """, (selected_min_rating, selected_max_rating))
                movies_by_rating = cur.fetchall()

                # Shows that have rating between min and max values
                cur.execute("""
                    SELECT s.s_id,
                           s.s_title,
                           s.s_releaseYear,
                           s.s_duration,
                           s.s_rating
                    FROM tables.show AS s
                    WHERE s.s_rating::numeric BETWEEN %s AND %s
                    ORDER BY s.s_rating::numeric DESC, s.s_title;
                """, (selected_min_rating, selected_max_rating))
                shows_by_rating = cur.fetchall()

    cur.close()
    conn.close()

    return render_template(
        "index.html",
        # genre data
        genres=genres,
        movies_by_genre=movies_by_genre,
        shows_by_genre=shows_by_genre,
        selected_genre_id=int(selected_genre_id) if selected_genre_id else None,
        selected_genre_name=selected_genre_name,
        
        # actor data
        actors=actors,
        movies_by_actor=movies_by_actor,
        shows_by_actor=shows_by_actor,
        selected_actor_id=int(selected_actor_id) if selected_actor_id else None,
        selected_actor_name=selected_actor_name,
        
        # rating data
        movies_by_rating=movies_by_rating,
        shows_by_rating=shows_by_rating,
        selected_min_rating=selected_min_rating,
        selected_max_rating=selected_max_rating,
    )


if __name__ == "__main__":
    app.run(debug=True)
