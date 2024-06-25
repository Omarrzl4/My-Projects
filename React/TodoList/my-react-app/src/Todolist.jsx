import { useEffect, useState } from "react";
import './todolist.css'

function Todolist(){
    const[tasks,setTasks]=useState([]);
    const[newTask,setnewTask]=useState("");
    const[count,setCount]=useState(0);

    useEffect(()=>{
      document.title=`You have ${count} tasks left`;
    },[count])

    function inputChange(event){
       setnewTask(event.target.value)

    }
    function addTask(){
        if(newTask.trim()!==""){
        setCount(count+1);
        
       setTasks(t=>[...t,newTask])
       setnewTask("");
       
        }
    
    }

     function deleteTask(index){
      setCount(count-1);
          setTasks(t=>tasks.filter((_,i)=>i !==index))
     }

     function movetaskUp(index){
       if(index>0){
        const updated=[...tasks];
        [updated[index],updated[index-1]]=[updated[index-1],updated[index]];
        setTasks(updated);
       }

     }
     function moveetaskDown(index){
          if(index<tasks.length -1){
            const update=[...tasks];
            [update[index],update[index+1]]=[update[index+1],update[index]];
            setTasks(update);
          }
     }

   return(
    <div className="todolist">
        <h1>To-do-list</h1>
        <div className="">
            <input type="text" placeholder="Enter a task..." value={newTask} onChange={inputChange}/>
        <button className="add-button" onClick={addTask}>Add</button>
        </div>
        <ol>
            {tasks.map((task,index)=>

            <li key={index}>
        
             <span className="text">{task}</span>

             <button className="delete-button" onClick={()=>deleteTask(index)}>Delete</button>
             <button className="move-up" onClick={()=>movetaskUp(index)}>Move Up</button>
             <button className="move-down" onClick={()=>moveetaskDown(index)}>Move Down</button>
            </li>)}
        </ol>
    </div>
   );

}
export default Todolist