from flask import Flask, render_template, redirect, request, url_for, jsonify
import cx_Oracle
import json

app = Flask(__name__)
roll_no = 0
faculty_id = 0
var = {}
faculty_name = ''

# Redirect to index.html to choose whether Student or Faculty
@app.route('/')
def index():
    return render_template("index.html")

# Redirect to Student Login Page


# Receiving,validating student login and redirecting to student welcome
@app.route('/student_login', methods=["POST", "GET"])
def student_login():
    global roll_no
    #creating a standalone connection
    conn = cx_Oracle.connect("?/?@localhost/orcl") # Add username and password in place of ?
    cur = conn.cursor()

    roll_no = request.form["roll_no"]
    pass_word = request.form["pass_word"]

    sql = """SELECT roll_no FROM students"""
    cur.execute(sql)
    student_list = [row[0] for row in cur.fetchall()]
    for x in student_list:
        if x == int(roll_no):
            sql = """SELECT pass_word FROM students WHERE roll_no=:xroll_no"""
            cur.execute(sql, ({'xroll_no': roll_no}))
            y = cur.fetchone()

            if pass_word == y[0]:
                sql = """select concat(concat(first_name,' '),last_name) from students where roll_no=:x_roll_no"""
                cur.execute(sql, ({'x_roll_no': roll_no}))
                student_name = cur.fetchall()
                cur.callproc("dbms_output.enable")
                cur.callproc('all_att', [roll_no])
                z = []
                textVar = cur.var(str) #creating a string variable textVar to hold the OUT parameter returned by PL/SQL Statement   
                statusVar = cur.var(int)
                while True:
                    cur.callproc("dbms_output.get_line", (textVar, statusVar))
                    if statusVar.getvalue() != 0: #status will be 0 if get_line executes successfully
                        break

                    y = textVar.getvalue()
                    x = list(y.split('\t'))
                    print(y)
                    for i in x:
                        if '' in x:
                            x.remove('')
                            print(x)
                    length = len(x)
                    z = z+x


                return render_template("student_welcome.html", length=length, att_list=z, roll_no=roll_no, student_name=student_name[0][0])
    cur.close()
    return render_template("student_login.html", error="Invalid Roll No/Password")

# Redirect to Faculty Login Page


# Receiving,validating faculty login and redirecting to faculty welcome
@app.route('/faculty_login', methods=["POST"])
def faculty_login():
    global faculty_id
    global faculty_name
    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()

    faculty_id = request.form["faculty_id"]
    pass_word = request.form["pass_word"]

    cur.execute("""SELECT faculty_id FROM faculty""")
    faculty_list = [row[0] for row in cur.fetchall()]
 #   print("HELOOOOO")
  #  print(faculty_list)
    for x in faculty_list:
        if x == int(faculty_id):
            sql = """SELECT pass_word FROM faculty WHERE faculty_id=:xfaculty_id"""
            cur.execute(sql, ({'xfaculty_id': faculty_id}))
            y = cur.fetchone()

            if pass_word == y[0]:
                sql = """select concat(concat(first_name,' '),last_name) from faculty where faculty_id=:x_faculty_id"""
                cur.execute(sql, ({'x_faculty_id': faculty_id}))
                faculty_name = cur.fetchall()
                conn = cx_Oracle.connect("?/?@localhost/orcl")
                cur = conn.cursor()

                sql = """SELECT c.course_id,c.course_name from teaches t inner join course c on t.course_id=c.course_id and faculty_id = :x_faculty_id"""
                cur.execute(sql, ({'x_faculty_id': faculty_id}))
                faculty_course = cur.fetchall()
             #   print(faculty_course)
                cur.close()
                return render_template("faculty_welcome.html", faculty_id=faculty_id, faculty_name=faculty_name[0][0],faculty_course=faculty_course)
    cur.close()
    return render_template("index.html", error="Invalid Faculty ID/Password")


@app.route('/faculty_details_to_login')
def faculty_login_to_login():
    global faculty_id
    global faculty_name
    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()

    faculty_id = request.form["faculty_id"]
    pass_word = request.form["pass_word"]

    cur.execute("""SELECT faculty_id FROM faculty""")
    faculty_list = [row[0] for row in cur.fetchall()]
 #   print("HELOOOOO")
  #  print(faculty_list)
    for x in faculty_list:
        if x == int(faculty_id):
            sql = """SELECT pass_word FROM faculty WHERE faculty_id=:xfaculty_id"""
            cur.execute(sql, ({'xfaculty_id': faculty_id}))
            y = cur.fetchone()

            if pass_word == y[0]:
                sql = """select concat(concat(first_name,' '),last_name) from faculty where faculty_id=:x_faculty_id"""
                cur.execute(sql, ({'x_faculty_id': faculty_id}))
                faculty_name = cur.fetchall()
                conn = cx_Oracle.connect(
                    "?/?@localhost/orcl")
                cur = conn.cursor()

                sql = """SELECT c.course_id,c.course_name from teaches t inner join course c on t.course_id=c.course_id and faculty_id = :x_faculty_id"""
                cur.execute(sql, ({'x_faculty_id': faculty_id}))
                faculty_course = cur.fetchall()
             #   print(faculty_course)
                cur.close()
                return render_template("faculty_welcome.html", faculty_id=faculty_id, faculty_name=faculty_name[0][0],faculty_course=faculty_course)
    cur.close()
    return render_template("index.html", error="Invalid Faculty ID/Password")

# Redirecting to index.html on clicking logout
@app.route('/logout')
def logout():
    return render_template("index.html")


# Displays students details to student_details.html
@app.route('/student_details')
def student_details():
    global roll_no
  #  print(roll_no)
    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()

    sql = """SELECT roll_no,first_name,last_name,initials,email_id,to_char(dob,'DD-MM-YYYY'),gender from students where roll_no = :x_roll_no"""
    cur.execute(sql, ({'x_roll_no': roll_no}))
    student_info = cur.fetchall()
   # print(student_info)
    return render_template("student_details.html", student_info=student_info)


# Displays faculty details to faculty_details.html
@app.route('/faculty_details')
def faculty_details():
    global faculty_id
    global faculty_name

    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()

    sql = """SELECT faculty_id,first_name,last_name,initials,email_id from faculty where faculty_id = :x_faculty_id"""
    cur.execute(sql, ({'x_faculty_id': faculty_id}))
    faculty_info = cur.fetchall()
   # print(faculty_info)
    return render_template("faculty_details.html", faculty_info=faculty_info,faculty_name=faculty_name[0][0])

# Route to allow navigation from Faculty Details to Home
@app.route('/faculty_details_to_home')
def faculty_details_to_home():
    global faculty_id
    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()
    global faculty_name

 #   print("HELOOOOO")
  #  print(faculty_list)

    sql = """SELECT c.course_id,c.course_name from teaches t inner join course c on t.course_id=c.course_id and faculty_id = :x_faculty_id"""
    cur.execute(sql, ({'x_faculty_id': faculty_id}))
    faculty_course = cur.fetchall()
    #   print(faculty_course)
    cur.close()
    return render_template("faculty_welcome.html", faculty_id=faculty_id, faculty_course=faculty_course,faculty_name=faculty_name[0][0])
    


# Displays how many classes a student can bunk to Modal
@app.route('/bunk_details', methods=["POST"])
def bunk_details():
    global roll_no
    x = dict(request.form)
    #x =  {"course_id":"CS6106"}

   # print(x['course_id'])
    bunk_course_id = x['course_id']

    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()

    cur.callproc("dbms_output.enable")
    cur.callproc('remain_bunk', [roll_no, bunk_course_id])

    textVar = cur.var(str)
    statusVar = cur.var(int)
    while True:
        cur.callproc("dbms_output.get_line", (textVar, statusVar))
        if statusVar.getvalue() != 0:
            break
        y = textVar.getvalue()

   # print(y)
   # y = json.dumps(y)
    cur.close()
    return {"msg": y}


# Displays courses taken by a faculty
@app.route('/attendance_shortage')
def attendance_shortage():
    global faculty_id
    global faculty_name

    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()

    sql = """SELECT c.course_id,c.course_name from teaches t inner join course c on t.course_id=c.course_id and faculty_id = :x_faculty_id"""
    cur.execute(sql, ({'x_faculty_id': faculty_id}))
    faculty_course = cur.fetchall()
    # print(faculty_course)
    cur.close()
    return render_template("faculty_attendance_shortage.html", faculty_id=faculty_id,faculty_name=faculty_name[0][0] ,faculty_course=faculty_course)


# Displays students who have shortage of attendance to faculty_attendance_shortage.html
@app.route('/attendance_shortage_student_details', methods=["POST"])
def attendance_shortage_student_details():
    global faculty_id
    x = dict(request.form)
    #x =  {"course_id":"CS6106"}

  #  print(x['course_id'])
    bunk_course_id = x['course_id']
   # print(bunk_course_id)
    # print(faculty_id)
    # print(type(bunk_course_id))
    faculty_id = int(faculty_id)
    # print(type(faculty_id))

    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()

    cur.callproc("dbms_output.enable")
    cur.callproc('att_shortage', [bunk_course_id, int(faculty_id)])

    z = []
    textVar = cur.var(str)
    statusVar = cur.var(int)
    while True:
        cur.callproc("dbms_output.get_line", (textVar, statusVar))
        if statusVar.getvalue() != 0:
            break

        y = textVar.getvalue()
        print(y)
        x = list(y.split('\t'))
        for i in x:
            if '' in x:
                x.remove('')
            length = len(x)
        z = z+x

        print(z)
    return {"len": length, "list": z}


@app.route('/mark_attendance')
def mark_attendance():
    global faculty_name
    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()

    sql = """SELECT c.course_id,c.course_name from teaches t inner join course c on t.course_id=c.course_id and faculty_id = :x_faculty_id"""
    cur.execute(sql, ({'x_faculty_id': faculty_id}))
    faculty_course = cur.fetchall()
#   print(faculty_course)
    cur.close()
    return render_template("mark_attendance.html", faculty_id=faculty_id,faculty_name=faculty_name[0][0] ,faculty_course=faculty_course)

@app.route('/marking_attendance',methods=['POST'])
def marking_attendance():   
    global faculty_id
    global zzz
    global var
    var=request.get_json()
    print(var)
    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()
    print(faculty_id,var['course_id'])
    sql = """select sf.roll_no,s.first_name,s.last_name from student_faculty sf inner join students s on s.roll_no = sf.roll_no and sf.faculty_id = :x_faculty_id and sf.course_id = :x_course_id"""
    cur.execute(sql,{"x_faculty_id":int(faculty_id),"x_course_id": var['course_id'] })
    zzz=cur.fetchall()
    print(zzz)

    return {"values": zzz}

@app.route('/start_mark_attendance')
def start_mark_attendance():
    
    return render_template('start_mark_attendance.html',student_list=zzz,hour=var['hour'])   

@app.route('/insert_attendance',methods=["POST"])
def insert_attendance():
    global faculty_id
    global var
    data = request.get_json(force=True)
    print(data)
   #{'x_present': ['2018103006', '2018103060'], 'x_absent': ['2018103075'], 'hour': [2]}
    conn = cx_Oracle.connect("?/?@localhost/orcl")
    cur = conn.cursor()
    
    if 'x_present' in data:
        for i in data['x_present']:
            print (i)
            sql= """insert into attendance_log(roll_no,course_id,faculty_id,hour) values(:1,:2,:3,:4)"""
            x = var['course_id']
            hr = int(data['hour'][0])
            print(hr)
            cur.execute(sql,[i,x,faculty_id,hr])
    if 'x_absent' in data:
        for i in data['x_absent']:
            print (i)
            sql= """insert into attendance_log(roll_no,course_id,faculty_id,hour) values(:1,:2,:3,:4)"""
            x = var['course_id']
            print(x)
            hr = -1 * int(data['hour'][0])
            print(hr)
            cur.execute(sql,[i,x,faculty_id,hr])
    conn.commit()
    cur.close()
    return {"hello":"Heloooooooooooo"}



if __name__ == "__main__":
    app.run(debug=True)
