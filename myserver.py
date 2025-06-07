from flask import *
from flask_mysqldb import MySQL
import matplotlib
matplotlib.use('Agg')
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import io
from io import BytesIO
import base64
import numpy as np
import math
from datetime import datetime

app = Flask(__name__)

# for database connection
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'SQLgeKMC@sem2'
app.config['MYSQL_DB'] = 'aakar'
mysql = MySQL(app)

# for user session management
app.config['SECRET_KEY'] = 'mysecretkey'

@app.route("/")
def home_page():
    return render_template("home_page.html")

@app.route("/signup")
def signup():
   session['loggedin'] = False
   dbconn = mysql.connection
   cursor = dbconn.cursor()
   cursor.execute("select email_id from user")
   emails = cursor.fetchall()
   emails = [i[0] for i in emails]
   print(emails)
   cursor.close()
   return render_template("pages-sign-up.html", existing_emails = emails)

@app.route("/createuser", methods=['POST'])
def createuser():
    email_id = request.form['email']
    password = request.form['password']
    full_name = request.form['name']
    page_name = request.form['signup']
    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute("insert into user(email_id, password, full_name) values(%s,%s,%s)",(email_id, password, full_name))
    dbconn.commit()
    cursor.close()
    return render_template("successful_signup.html", message = "Successfully registered")

@app.route("/signin")
def signin():
    return render_template("pages-sign-in.html")

@app.route("/createsession",methods=['POST'])
def createsession():
    email_id=request.form['email']
    password=request.form['password']
    dbconn=mysql.connection
    cursor=dbconn.cursor()
    cursor.execute("select email_id,full_name,password from user where email_id=%s and password=%s",(email_id,password))
    user=cursor.fetchone()
    flag=0
    if user:
        flag=1
        session['loggedin']=True
        session['full_name']=user[1]
        session['email'] = user[0]
        session['password'] = user[2]
        cursor.execute("select year_col, month_col, budget from monthly_budget where email_id = %s order by year_col desc, month_col desc limit 1", (session['email'],)) #change dec-05
        res = cursor.fetchone() #change dec-05
        cursor.execute("select transaction_id, transaction_date, category_name, amount, description from transactions as t join category as c on t.category_id = c.category_id where email_id=%s order by transaction_date desc limit 10", (session['email'],)) #change dec-05
        res1 = cursor.fetchall()
        return render_template("pages-profile.html",flag = flag, budget = res, transactions = res1) #change dec-05
    else:
        return render_template("pages-sign-in.html",flag = flag)

@app.route("/profile")
def profile():
    if session:
        if session['loggedin']==True:
            dbconn=mysql.connection #change dec-05
            cursor=dbconn.cursor() ##change dec-05
            cursor.execute("select year_col, month_col, budget from monthly_budget where email_id = %s order by year_col desc, month_col desc limit 1", (session['email'],)) #change dec-05
            res = cursor.fetchone() #change dec-05
            cursor.execute("select transaction_id, transaction_date, category_name, amount, description from transactions as t join category as c on t.category_id = c.category_id where email_id=%s order by transaction_date desc limit 10", (session['email'],)) #change dec-05
            res1 = cursor.fetchall()
            return render_template("pages-profile.html", budget = res, transactions = res1) #change dec-05
        else:
            return render_template("pages-sign-in.html")
    else:
        return render_template("pages-sign-in.html")

@app.route("/add_transactions")
def add_transactions():
    if session:
        if session['loggedin']==True:
            return render_template("add-transactions.html")
        else:
            return render_template("pages-sign-in.html")
    else:
        return render_template("pages-sign-in.html")

@app.route("/delete_transactions")
def delete_transactions():
    if session:
        if session['loggedin']==True:
            return render_template("delete-transactions.html")
        else:
            return render_template("pages-sign-in.html")
    else:
        return render_template("pages-sign-in.html")


@app.route("/update_transactions")
def update_transactions():
    if session:
        if session['loggedin']==True:
            return render_template("update-transactions.html")
        else:
            return render_template("pages-sign-in.html")
    else:
        return render_template("pages-sign-in.html")

@app.route("/transaction_details",methods=['POST'])
def transaction_details():
    if session:
        if session['loggedin']==True:
            page_name=request.form['page_name']
            if page_name=="add_transactions" or page_name=="delete_transactions" or page_name=="update_transactions":
                transaction_date=request.form["date"]
                dbconn=mysql.connection
                cursor=dbconn.cursor()
                cursor.execute("select t.transaction_id,c.category_name,t.transaction_date,t.amount,t.description from transactions t left join category c on c.category_id=t.category_id where t.transaction_date=%s and t.email_id=%s",(transaction_date,session['email']))
                transactions=cursor.fetchall()
                cursor.close()
                return render_template("transaction-details.html",transactions=transactions,page_name=page_name)
            elif page_name=="transactions":
                transaction_date=request.form.get("date")
                category=request.form.get("category")
                dbconn=mysql.connection
                cursor=dbconn.cursor()
                if ((not(transaction_date)) and (not(category))):
                    return redirect("/transactions")
                elif ((not(transaction_date)) and (category)):
                    if category=="Food":
                        category_id=1
                    elif category=="Household or Ration":
                        category_id=2
                    elif category=="Miscellaneous":
                        category_id=3
                    elif category=="Shopping or Entertainment":
                        category_id=4
                    elif category=="Accomodation":
                        category_id=5
                    cursor.execute("select t.transaction_id,t.transaction_date,c.category_name,t.amount,t.description from transactions t left join category c on c.category_id=t.category_id where t.category_id=%s and t.email_id=%s",(category_id,session['email']))
                    transactions=cursor.fetchall()
                    cursor.close()
                    return render_template("transaction-details.html",transactions=transactions,page_name=page_name)
                elif ((transaction_date) and (category)):
                    if category=="Food":
                        category_id=1
                    elif category=="Household or Ration":
                        category_id=2
                    elif category=="Miscellaneous":
                        category_id=3
                    elif category=="Shopping or Entertainment":
                        category_id=4
                    elif category=="Accomodation":
                        category_id=5
                    cursor.execute("select t.transaction_id,t.transaction_date,c.category_name,t.amount,t.description from transactions t left join category c on c.category_id=t.category_id where t.category_id=%s and t.transaction_date=%s and t.email_id=%s",(category_id,transaction_date,session['email']))
                    transactions=cursor.fetchall()
                    cursor.close()
                    return render_template("transaction-details.html",transactions=transactions,page_name=page_name)
                elif ((transaction_date) and (not(category))):
                    cursor.execute("select t.transaction_id,c.category_name,t.transaction_date,t.amount,t.description from transactions t left join category c on c.category_id=t.category_id where t.transaction_date=%s and t.email_id=%s",(transaction_date,session['email']))
                    transactions=cursor.fetchall()
                    cursor.close()
                    return render_template("transaction-details.html",transactions=transactions,page_name=page_name)
        else:
            return render_template("pages-sign-in.html")
    else:
        return render_template("pages-sign-in.html")
    

@app.route("/prompt",methods=['POST'])
def prompt():
    if session:
        if session['loggedin']==True:
            page_name=request.form["page_name"]
            if page_name=="add_transactions":
                transaction_date=request.form["date"]
                category=request.form["category"]
                amount=float(request.form["amount"])
                desc = request.form["desc"]
                if category=="Food":
                    category_id=1
                elif category=="Household or Ration":
                    category_id=2
                elif category=="Miscellaneous":
                    category_id=3
                elif category=="Shopping or Entertainment":
                    category_id=4
                elif category=="Accomodation":
                    category_id=5
                dbconn=mysql.connection
                cursor=dbconn.cursor()
                cursor.execute("insert into transactions (transaction_date,email_id,category_id,amount,description) values (%s,%s,%s,%s,%s)",(transaction_date,session['email'],category_id,amount,desc))
                dbconn.commit()
                cursor.close()
                return render_template("prompt.html",page_name=page_name)
            elif page_name=="delete_transactions_details":
                transaction_id=request.form.getlist("transaction_id")
                if transaction_id:
                    transaction_tuple=()
                    for i in transaction_id:
                        transaction_tuple+=(int(i),)
                        values=', '.join(['%s'] * len(transaction_tuple))
                        dbconn=mysql.connection
                        cursor=dbconn.cursor()
                        cursor.execute(f"delete from transactions where transaction_id in ({values})",transaction_tuple)
                        dbconn.commit()
                        cursor.close()
                        return render_template("prompt.html",page_name=page_name)
                else:
                    return redirect("/delete_transactions")

            elif page_name=="update_transactions_details":
                transaction_id=request.form['transaction_id']
                transaction_date=request.form.get('date')
                category=request.form.get('category')
                amount=request.form.get('amount')
                desc=request.form.get('desc')
                dbconn=mysql.connection
                cursor=dbconn.cursor()
                update_query = "UPDATE transactions SET"
                params = []

                if transaction_date:
                    update_query += " transaction_date = %s,"
                    params.append(transaction_date)
                if category:
                    update_query += " category = %s,"
                    params.append(category)
                if amount:
                    update_query += " amount = %s,"
                    params.append(amount)
                if desc:
                    update_query += " description = %s,"
                    params.append(desc)

                if update_query.endswith(','):
                    update_query = update_query[:-1]
                
                if len(params) == 0:
                    return redirect("/update_transactions")

                update_query += " WHERE transaction_id = %s"
                
                params.append(transaction_id)
                cursor.execute(update_query, tuple(params))
                dbconn.commit()
                cursor.close()
                return render_template('prompt.html', page_name=page_name)
        
        else:
            return render_template("pages-sign-in.html")
    else:
        return render_template("pages-sign-in.html")


@app.route("/transactions")
def transactions():
    if session:
        if session['loggedin']==True:
            dbconn=mysql.connection
            cursor=dbconn.cursor()
            cursor.execute("select t.transaction_id,t.transaction_date,c.category_name,t.amount,t.description from transactions t left join category c on c.category_id=t.category_id where t.email_id=%s order by t.transaction_date desc",(session['email'],))
            transactions=cursor.fetchall()
            cursor.close()
            return render_template("transactions.html",transactions=transactions)
        else:
            return render_template("pages-sign-in.html")
    else:
        return render_template("pages-sign-in.html")

@app.route("/update_budget")
def update_budget():
    return render_template("update_budget.html", message="Update your monthly budget")

@app.route("/budget_insert", methods=['POST'])
def budget_insert():
    year = request.form['year']
    month = request.form['month']
    budget = request.form['budget']
    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute("insert into monthly_budget values(%s,%s,%s,%s)",(year, month, session['email'], budget))
    dbconn.commit()
    cursor.close()
    return render_template("budget_insert.html", message="Monthly budget updated successfully")

@app.route("/signout")
def logout():
    if session:        
        if session['loggedin'] == True:
            session.pop('password', None)
            session.pop('email', None)
            session.pop('full_name', None)
            session.pop('loggedin', None)
            return redirect("/")
        else:
            return redirect('/signin')
    else:
        return render_template("pages-sign-in.html")

@app.route("/delete_account")
def delete_account():
    if session:
        if session['loggedin'] == True:
            return render_template("delete_account.html", message = "Are you sure you want to delete your account ?")
        else:
            return redirect('/signin')
    else:
        return render_template("pages-sign-in.html")


@app.route("/delete_acc_successful", methods=['POST'])
def delete_acc_successful():
    email = request.form['email']
    password =  request.form['password']
    dbconn=mysql.connection
    cursor=dbconn.cursor()
    if (email == session['email']) and (password == session['password']):
        cursor.execute("delete from user where email_id=%s and password=%s", (email,password))
        dbconn.commit()
        cursor.close()
        session.pop('password', None)
        session.pop('email', None)
        session.pop('full_name', None)
        session.pop('loggedin', None)
        return render_template("delete_acc_successful.html", message="Account deleted successfully") #change dec-06
    else:
        return render_template("delete_account.html", message="Invalid Credentials")

@app.route("/change_password")
def change_password():
    if session:
        if session['loggedin'] == True:
            return render_template("change_password.html", message = "Change Password")
        else:
            return redirect('/signin')
    else:
        return render_template("pages-sign-in.html")


@app.route("/change_pwd_successful", methods=['POST'])
def change_pwd_successful():
    old_password = request.form['old_password']
    new_password =  request.form['new_password']
    new_password_confirm =  request.form['new_password_confirm']
    dbconn=mysql.connection
    cursor=dbconn.cursor()
    if (old_password == session['password']) and (new_password == new_password_confirm):
        cursor.execute("update user set password=%s where email_id=%s", (new_password, session['email']))
        dbconn.commit()
        cursor.close()
        session.pop('password', None)
        session.pop('email', None)
        session.pop('full_name', None)
        session.pop('loggedin', None)
        return render_template("change_pwd_successful.html", message="Password changed successfully")
    
    elif (old_password != session['password']):
        return render_template("change_password.html", message = "Invalid Credentials")
    
    elif (new_password != new_password_confirm):
        return render_template("change_password.html", message = "New passwords did not match")

@app.route("/dashboard")
def dashboard():
    if session:
        if session['loggedin'] == True:
            dbconn = mysql.connection
            cursor = dbconn.cursor()

            # Fetch transaction count and sum
            cursor.execute("SELECT count(transaction_id) AS no_of_transactions FROM transactions WHERE email_id=%s", (session['email'],))
            transaction_all = (cursor.fetchone())[0]

            cursor.execute("SELECT round(sum(amount), 2) AS sum_of_trans FROM transactions WHERE email_id=%s", (session['email'],))
            sum_all = (cursor.fetchone())[0]

            # Combo chart (Bar + Line chart)
            cursor.execute("""
                SELECT trans.date_t, ROUND(SUM(trans.amount), 3) AS total_amount 
                FROM (
                    SELECT *, CONCAT(LPAD(MONTH(transaction_date), 2, '0'), '-', YEAR(transaction_date)) AS date_t 
                    FROM transactions WHERE email_id=%s
                ) trans 
                GROUP BY trans.date_t 
                ORDER BY MIN(trans.transaction_date) ASC
            """, (session['email'],))
            results_bar = cursor.fetchall()

            if results_bar:
                # Budget data
                cursor.execute("""
                    SELECT CONCAT(month_col, '-', year_col) AS month_year, budget 
                    FROM monthly_budget 
                    WHERE email_id=%s 
                    ORDER BY year_col, month_col
                """, (session['email'],))
                results_line = cursor.fetchall()
                
                x_bar, y_bar = zip(*results_bar) if results_bar else ([], [])
                x_line, y_line = zip(*results_line) if results_line else ([], [])

                # Parse months into datetime objects
                x_bar_dates = [datetime.strptime(date, "%m-%Y") for date in x_bar]
                x_line_dates = [datetime.strptime(date, "%m-%Y") for date in x_line]

                # Combine and sort all dates
                all_months_dates = sorted(set(x_bar_dates + x_line_dates))
                all_months = [date.strftime("%m-%Y") for date in all_months_dates]
                y_bar_aligned = [y_bar[x_bar_dates.index(month)] if month in x_bar_dates else 0 for month in all_months_dates]
                y_line_aligned = [y_line[x_line_dates.index(month)] if month in x_line_dates else 0 for month in all_months_dates]

                # Plotting Combo Chart
                plt.figure(figsize=(8, 5))
                x_indices = np.arange(len(all_months))
                plt.bar(x_indices, y_bar_aligned, color="skyblue", label="Total Transactions")
                plt.plot(x_indices, y_line_aligned, color="#003153", marker="o", label="Budget")
                plt.xticks(ticks=x_indices, labels=all_months, rotation=90)
                plt.xlabel("Date")
                plt.ylabel("Amount (Rs.)")
                plt.legend(loc="upper left", bbox_to_anchor=(1, 1), title="Legend", fontsize=10)
                combo_chart = save_plot_to_base64()
            else:
                combo_chart = "No data available for combo chart"

            # Doughnut chart
            cursor.execute("""
                SELECT c.category_name, s_c.cat_sum 
                FROM category c 
                LEFT JOIN (
                    SELECT category_id, ROUND(SUM(amount), 2) AS cat_sum 
                    FROM transactions 
                    WHERE email_id=%s 
                    GROUP BY category_id 
                    ORDER BY category_id
                ) s_c 
                ON s_c.category_id = c.category_id
            """, (session['email'],))
            results = cursor.fetchall()

            if results:
                labels = []
                sizes = []

                for i in results:
                    labels.append(i[0])
                    if i[1] is None or isinstance(i[1], float) and (i[1] != i[1]):  # Check for None or NaN
                        sizes.append(0)  # Replace None or NaN with 0
                    else:
                        sizes.append(i[1])

                # Check if all values are zero
                if all(size == 0 for size in sizes):
                    doughnut_chart = "No data available for doughnut chart"
                else:
                    # Plotting Doughnut Chart
                    plt.figure(figsize=(6, 6))
                    colors = ['#3b7ddd', '#1cbb8c', '#fcb92c', '#ced4da', '#dc3545']
                    wedges = plt.pie(sizes, startangle=90, colors=colors, wedgeprops={"edgecolor": "black"})[0]
                    total = sum(sizes)

                    # Create legend with percentages
                    plt.legend(wedges, [f"{label}: Rs. {size} ({(size / total * 100):.1f}%)" for label, size in zip(labels, sizes)],
                               title="Categories", loc="center left", bbox_to_anchor=(1, 0.5))

                    # Add a white circle in the middle to create a doughnut chart
                    plt.gca().add_artist(plt.Circle((0, 0), 0.70, fc="white"))

                    # Save the plot as base64
                    doughnut_chart = save_plot_to_base64()
            else:
                doughnut_chart = "No data available for doughnut chart"

            return render_template("dashboard.html", transaction_all=transaction_all, sum_all=sum_all, combo_chart=combo_chart, doughnut_chart=doughnut_chart)
        else:
            return render_template("pages-sign-in.html")
    else:
        return render_template("pages-sign-in.html")


@app.route("/dashboard_category",methods=['POST'])
def dashboard_category():
    if session:
        if session['loggedin']==True:
            category=request.form.get("category")
            if category:
                if category=="Food":
                    category_id=1
                elif category=="Household or Ration":
                    category_id=2
                elif category=="Miscellaneous":
                    category_id=3
                elif category=="Shopping or Entertainment":
                    category_id=4
                elif category=="Accomodation":
                    category_id=5
                dbconn=mysql.connection
                cursor=dbconn.cursor()
                cursor.execute("select t.transaction_id,t.transaction_date,c.category_name,t.amount from transactions t left join category c on c.category_id=t.category_id where t.email_id=%s and t.category_id=%s order by t.transaction_date desc",(session['email'],category_id))
                category_transactions=cursor.fetchall()
                cursor.execute("select count(transaction_id) as no_of_transactions from transactions where email_id=%s and category_id=%s",(session['email'],category_id))
                no_of_trans=(cursor.fetchone())[0]
                cursor.execute("select round(sum(amount),2) as sum_of_trans from transactions where email_id=%s and category_id=%s",(session['email'],category_id))
                sum_of_trans=(cursor.fetchone())[0]
                return render_template("dashboard_category.html",no_of_trans=no_of_trans,category_transactions=category_transactions,sum_of_trans=sum_of_trans,category=category)
            else:
                return redirect("/dashboard")
        else:
            return render_template("pages-sign-in.html")
    else:
        return render_template("pages-sign-in.html")

# Generate combo chart (bar and line)
def generate_combo_chart():
    dbconn = mysql.connection
    cursor = dbconn.cursor()
    
    # Transactions data
    cursor.execute("SELECT trans.date_t,ROUND(SUM(trans.amount), 3) AS total_amount FROM (SELECT *, CONCAT(LPAD(MONTH(transaction_date), 2, '0'), '-', YEAR(transaction_date)) AS date_t FROM transactions where email_id=%s) trans GROUP BY trans.date_t ORDER BY  MIN(trans.transaction_date) ASC", (session['email'],))
    results_bar = cursor.fetchall()
    
    # Budget data
    cursor.execute("""
        SELECT CONCAT(month_col, '-', year_col) AS month_year, budget 
        FROM monthly_budget 
        WHERE email_id=%s 
        ORDER BY month_col, year_col
    """, (session['email'],))
    results_line = cursor.fetchall()
    cursor.close()
    
    # Extract data
    x_bar, y_bar = zip(*results_bar) if results_bar else ([], [])
    x_line, y_line = zip(*results_line) if results_line else ([], [])
    
    # Align data
    all_months = sorted(set(x_bar + x_line))
    y_bar_aligned = [y_bar[x_bar.index(month)] if month in x_bar else 0 for month in all_months]
    y_line_aligned = [y_line[x_line.index(month)] if month in x_line else 0 for month in all_months]
    
    # Plotting
    plt.figure(figsize=(8, 5))
    x_indices = np.arange(len(all_months))
    plt.bar(x_indices, y_bar_aligned,color="skyblue", label="Total Transactions")
    plt.plot(x_indices, y_line_aligned, color="#003153", marker="o", label="Budget")
    plt.xticks(ticks=x_indices, labels=all_months, rotation=90)
    plt.xlabel("Date")
    plt.ylabel("Amount (rs.)")
    plt.legend(loc="upper left", bbox_to_anchor=(1, 1), title="Legend", fontsize=10)
    
    return save_plot_to_base64()

# Generate doughnut chart
def generate_doughnut_chart():
    dbconn=mysql.connection
    cursor=dbconn.cursor()
    cursor.execute("select c.category_name,s_c.cat_sum from category c left join (select category_id,round(sum(amount),2) as cat_sum from transactions where email_id=%s group by category_id order by category_id) s_c on s_c.category_id=c.category_id",(session['email'],))
    results=cursor.fetchall()
    if results:
        labels=[]
        sizes=[]
        for i in results:
            labels.append(i[0])
            if not i[1]:
                sizes.append(0)
            else:
                sizes.append(i[1])
        plt.figure(figsize=(6, 6))
        colors =['#3b7ddd', '#1cbb8c', '#fcb92c', '#ced4da', '#dc3545']
        wedges= plt.pie(sizes,startangle=90,colors=colors,wedgeprops={"edgecolor": "black"})[0]
        total = sum(sizes)
        plt.legend(wedges,[f"{label}: Rs. {size} ({(size / total * 100):.1f}%)" for label, size in zip(labels, sizes)],title="Categories",loc="center left",bbox_to_anchor=(1, 0.5))
        # Add a white circle in the middle to create a doughnut chart
        plt.gca().add_artist(plt.Circle((0, 0), 0.70, fc="white"))
        return save_plot_to_base64()

# Save plot as base64
def save_plot_to_base64():
    img = BytesIO()
    plt.savefig(img, format="png", bbox_inches="tight")
    img.seek(0)
    plt.close()
    return base64.b64encode(img.getvalue()).decode("utf-8")

app.run(debug=True)