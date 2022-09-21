# from crypt import methods
# from crypt import methods
import os
from flask import Flask,render_template,redirect,request,session, url_for,flash
from flask_mail import Mail
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import MySQLdb
import json
from werkzeug.utils import secure_filename
import math

with open('config.json', 'r') as con:
    params = json.load(con)["parameters"]

# UPLOAD_FOLDER = '/static/uploads/'
ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS




app = Flask(__name__)
app.secret_key = 'the random string'
app.config['UPLOAD_FOLDER'] = params['upload_location']


# app.config.update(
#     MAIL_SERVER = 'smtp.gmail.com',
#     MAIL_PORT = '465',
#     MAIL_USE_SSL = True,
#     MAIL_USERNAME = params['mail'],
#     MAIL_PASSWORD = params['mail_pwd']

# )
# mail=Mail(app)

if(params['local_server']):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
db = SQLAlchemy(app)


class Contact(db.Model):

# id, name, phone, email, msg , date 

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    phone = db.Column(db.String(15), unique=False, nullable=False)
    email = db.Column(db.String(25), unique=False, nullable=False)
    msg = db.Column(db.String(150), unique=False, nullable=False)
    date = db.Column(db.String(12), unique=False, nullable=False)
    

class Posts(db.Model):

# id, title, subheading, slug, img_file, content, date 

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(50), unique=False, nullable=False)
    subheading = db.Column(db.String(50), unique=False, nullable=False)
    slug = db.Column(db.String(50), unique=False, nullable=False)
    img_file = db.Column(db.String(20), unique=False, nullable=False)
    content = db.Column(db.String(280), unique=False, nullable=False)
    date = db.Column(db.String(12), unique=False, nullable=False)

@app.route("/")
def home():
    
    posts = Posts.query.all()[:params['no_of_post']]
    return render_template("index.html", params=params, posts=posts)
    
    

@app.route("/dashboard", methods=['GET','POST'])
def dashboard():
    if 'user' in session and session['user'] == params['admin_id']:
        posts = Posts.query.all()[:params['no_of_post']]

        return render_template('dashboard.html', params=params, posts=posts)

    if request.method=='POST':
        username = request.form.get('user')
        userpass = request.form.get('pwd')
       
        if (username == params["admin_id"]) and (userpass == params["admin_pwd"]) :
            session['user'] = username
            return render_template("dashboard.html",params = params)
   
    return render_template("login.html", params = params)


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect("/dashboard")
    # return render_template("login.html",params=params)




@app.route("/about")
def about():
    return render_template("about.html", params=params)





@app.route("/post/<string:post_slug>", methods=['GET', 'POST'])
def post_func(post_slug):
    posts = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html", params=params, posts = posts)




@app.route("/post")
def allpost(): 
    # posts = Posts.query.filter_by().all()

    no_of_posts = params['no_of_post_per_page']
    page = request.args.get("number")
    if page is None:
        page = 1
    else:
        page = int(page)
    allPosts = Posts.query.filter_by().all()
    length = len(allPosts)
    totalPage = math.ceil(length/no_of_posts)
    allPosts = allPosts[(page-1)*no_of_posts: page*no_of_posts]
    if page > 1:
        prev = page -1
    else:
        prev = None
    if page < math.ceil(length/no_of_posts):
        next = page + 1
    else:
        next = None
    
    return render_template('abcd.html', params=params, posts=allPosts, prev=prev, next=next, totalPage=totalPage)

    # posts = Posts.query.all()[:params['no_of_post_in_post_page']]
    # return render_template("abcd.html", params=params, posts=posts)



@app.route("/delete/<string:id>")
def delete(id): 
    if 'user' in session and session['user'] == params['admin_id']:
        post = Posts.query.filter_by(id=id).first()
        os.remove(os.path.join(app.config['UPLOAD_FOLDER'], post.img_file))
        db.session.delete(post)
        db.session.commit()
        return redirect("/dashboard")
    return render_template("login.html", params = params)        




@app.route("/update/<string:id>", methods=['GET','POST'])
def update(id): 
    if 'user' in session and session['user'] == params['admin_id']:    
        if request.method == 'POST':
            f = request.files['file']
            if f.filename == "":
                title = request.form['title']
                desc = request.form['blog']
                s_head = request.form['subheading']
                slug = request.form['slug']           
            
            # id, title, subheading, slug, img_file, content, date 
            
                posts = Posts.query.filter_by(id=id).first()
                posts.title = title
                posts.content=desc
                posts.slug = slug
                posts.subheading = s_head
                
                db.session.add(posts)
                db.session.commit()
                return redirect("/dashboard")
            else:
                title = request.form['title']
                desc = request.form['blog']
                s_head = request.form['subheading']
                slug = request.form['slug'] 

                posts = Posts.query.filter_by(id=id).first()

                if posts.img_file != "":
                    os.remove(os.path.join(app.config['UPLOAD_FOLDER'], posts.img_file))
                    f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
                    img = f.filename
                else:
                    f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
                    img = f.filename
                
                          
            
            # id, title, subheading, slug, img_file, content, date 
            
                
                posts.title = title
                posts.content=desc
                posts.slug = slug
                posts.subheading = s_head
                posts.img_file = img                    


            
                db.session.add(posts)
                db.session.commit()
                return redirect("/dashboard")

        posts = Posts.query.filter_by(id=id).first()
                
        return render_template("update.html", params=params, posts=posts)
    return render_template("login.html", params = params)  


@app.route("/contact", methods=['GET','POST'])
def contact():
    if request.method == 'POST':
        name = request.form['name']
        phone = request.form['phone']
        email = request.form['email']
        msg = request.form['msg']
         
        # id, name, phone, email, msg , date 
        
        entry = Contact(name=name, phone=phone, email=email, msg=msg, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        # mail.send_message('Blog msg from'+ name, sender=email, recipients=[params['mail']], body=msg + "\n" + phone )

        return redirect("contact.html")
    


    return render_template("contact.html", params=params)


@app.route("/addpost", methods=['GET','POST'])
def addpost():
    if 'user' in session and session['user'] == params['admin_id']:    
        if request.method == 'POST':
            
            
            title = request.form['title']
            content = request.form['blog']
            subhead = request.form['subheading']
            slug = request.form['slug']
            # slug = '1'


            f = request.files['file']
            
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))

            img=f.filename

            
            # id, name, phone, email, msg , date 
            entry = Posts(title=title, subheading=subhead, slug=slug, img_file=img, content=content, date=datetime.now())        
            # entry = Contact(name=name, phone=phone, email=email, msg=msg, date=datetime.now())
            db.session.add(entry)
            db.session.commit()
            # mail.send_message('Blog msg from'+ name, sender=email, recipients=[params['mail']], body=msg + "\n" + phone )

            return redirect("/dashboard")

        return render_template("dashboard.html", params=params)
    return render_template("login.html", params = params) 










app.run(debug=True)
