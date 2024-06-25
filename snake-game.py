from tkinter import *
import random

GAME_WIDTH=650
GAME_HEIGHT=650
SPEED=100
SPACE_SIZE=50
BODY_PARTS=3
SNAKE_COLOR="green"
FOOD_COLOR="red"
BG_COLOR="BLACK"


class Snake():
    def __init__(self):
        self.body_size=BODY_PARTS
        self.coordinates=[]
        self.squares=[]

        for i in range(0,BODY_PARTS):
            self.coordinates.append([0,0])

        for x,y in self.coordinates:
            square=canvas.create_rectangle(x,y,x+SPACE_SIZE,y+SPACE_SIZE,fill=SNAKE_COLOR,tags="snake")
            self.squares.append(square)

class Food():
    def __init__(self):
        x=random.randint(0,(GAME_WIDTH//SPACE_SIZE)-1) * SPACE_SIZE
        y = random.randint(0, (GAME_HEIGHT//SPACE_SIZE)-1) * SPACE_SIZE

        self.coordinates=[x,y]#coordinates of the snake head

        canvas.create_oval(x,y,x+SPACE_SIZE,y+SPACE_SIZE,fill=FOOD_COLOR,tag="food")
def next_turn(snake,food):

    x,y=snake.coordinates[0]
    if direction =="w":
          y-=SPACE_SIZE
    elif direction=="s":
          y+=SPACE_SIZE
    elif direction=="a":
          x-=SPACE_SIZE
    elif direction=="d":
         x+=SPACE_SIZE

    snake.coordinates.insert(0,(x,y))
    square=canvas.create_rectangle(x,y,x+SPACE_SIZE,y+SPACE_SIZE,fill=SNAKE_COLOR)
    snake.squares.insert(0,square)

    if x==food.coordinates[0] and y==food.coordinates[1]:

        global score

        score+=1
        label.config(text="Score:{}".format(score))
        canvas.delete("food")

        food = Food()

    else:
         del snake.coordinates[-1]
         canvas.delete(snake.squares[-1])
         del snake.squares[-1]

    if check(snake):
             gameOver()
    else:

             window.after(SPEED,next_turn,snake,food)
def change(newdirection):
    global direction
    if newdirection=="a":
        if direction!="d":
            direction=newdirection
    if newdirection == "d":
        if direction != "a":
            direction = newdirection
    if newdirection == "s":
        if direction != "w":
            direction = newdirection

    if newdirection == "w":
        if direction != "s":
            direction = newdirection


def check(snake):
    x,y=snake.coordinates[0]
    if x<0 or x>=GAME_WIDTH:
        return True
    elif y<0 or y>=GAME_HEIGHT:
        return True

    for i in snake.coordinates[1:]:
        if x==i[0] and y==i[1]:
            return True
def gameOver():
    canvas.delete(ALL)
    canvas.create_text((canvas.winfo_width()/2),(canvas.winfo_height()/2),font=("",40,"bold"),text="GAME_OVER",fill="red")


window=Tk()
window.bind("<w>",lambda event:change("w"))
window.bind("<a>",lambda event:change("a"))
window.bind("<s>",lambda event:change("s"))
window.bind("<d>",lambda event:change("d"))



score=0
direction="d"
label=Label(window,text="Score: {}".format(score),font=("",30,"bold"),foreground="Blue")
label.pack()


canvas=Canvas(window,width=GAME_WIDTH,height=GAME_HEIGHT,bg=BG_COLOR)
canvas.pack()

window.update()
window_width=window.winfo_width()
window_height=window.winfo_height()
screen_width=window.winfo_screenwidth()
screen_height=window.winfo_screenheight()

x=int(((screen_width/2)-(window_width/2)))
y=int(((screen_height/2)-(window_height/2)))
#window.geometry(f"{window_width}x{window_height}+{x}+{y}")kermel santer lsheshe


snake=Snake()
food=Food()

next_turn(snake,food)
window.mainloop()