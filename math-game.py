import random
import time
from tkinter import *

OPERATORS = ["+", "-", "*"]
start_num = 1
last_num = 9
QUESTIONS = 5
realAnswers = []
counter = 1
grade = 0

def generate():
    first = random.randint(start_num, last_num)
    second = random.randint(start_num, last_num)
    third = random.randint(start_num, 2)
    sign = random.choice(OPERATORS)
    exp = str(first) + " " + sign + " " + str(second) + " " + sign + " " + str(third)
    answer = eval(exp)
    return exp, answer

def check():
    global TRIES
    global counter
    global grade
    global real
    global entry
    global frame_content

    TRIES = 2

    if int(entry.get()) == realAnswers[0] and counter < QUESTIONS:
        counter += 1
        grade += 1
        realAnswers.clear()
        answers = generate()
        realAnswers.append(answers[1])
        print(realAnswers)
        l = Label(frame_content, text="Question number " + str(counter) + " : ",font=("",15,"bold"))
        l.pack()
        lanswer = Label(frame_content, text=answers[0] + " = ",font=("",15,"bold"))
        lanswer.pack()
        entry = Entry(frame_content,font=("",15,"bold"))
        entry.pack()
        butt = Button(frame_content, text="submit", command=check,font=("",15,"bold"))
        butt.pack()
        canvas.yview_moveto(1)
    else:
        label = Label(frame_content, text="Game Over", font=("", 40, "bold"), foreground="red")
        label.pack()
        label2 = Label(frame_content, text="You got " + str(grade) + " answers correct", font=("", 20, "bold"), foreground="blue")
        label2.pack(side="top")
        end_T = time.time()
        taken_Time = end_T - start_T
        label3 = Label(frame_content, text=f"Total time taken: {taken_Time:.2f} seconds",font=("",20,"bold"),foreground="orange")
        label3.pack()

window = Tk()
window.geometry("700x700")


canvas = Canvas(window)
frame = Frame(canvas)
scroll_y = Scrollbar(window, orient="vertical", command=canvas.yview)
scroll_x = Scrollbar(window, orient="horizontal", command=canvas.xview)

canvas.configure(yscrollcommand=scroll_y.set, xscrollcommand=scroll_x.set)

scroll_y.pack(side="right", fill="y")
scroll_x.pack(side="bottom", fill="x")
canvas.pack(side="left", fill="both", expand=True)
canvas.create_window((0, 0), window=frame, anchor="nw")

frame_content = Frame(frame)
frame_content.pack(fill='both', expand=True)

frame.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))

label = Label(frame_content, text="Time Started,Only One Chance !",font=("",35,"italic"),foreground="green")
label.pack()
start_T = time.time()
end_T = None

answers = generate()

l = Label(frame_content, text="Question number 1",font=("",15,"bold"))
l.pack()
lanswer = Label(frame_content, text=answers[0] + " = ",font=("",15,"bold"))
lanswer.pack()
entry = Entry(frame_content,font=("",15,"bold"))
entry.pack()
real = answers[1]
realAnswers.append(real)

butt = Button(frame_content, text="submit", command=check,font=("",15,"bold"))
butt.pack()

print(realAnswers)

window.mainloop()
