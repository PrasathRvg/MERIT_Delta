let arrow = document.querySelectorAll(".arrow");
for (var i = 0; i < arrow.length; i++) {
  arrow[i].addEventListener("click", (e)=>{
 let arrowParent = e.target.parentElement.parentElement; 
 arrowParent.classList.toggle("showMenu");
  });
}
let sidebar = document.querySelector(".sidebar");
let sidebarBtn = document.querySelector(".bx-menu");
console.log(sidebarBtn);
sidebarBtn.addEventListener("click", ()=>{
  sidebar.classList.toggle("close");
});



function fn1() {
  var rd1 = document.getElementById('rd1');
  var rd2 = document.getElementById('rd2');

  if (rd1.checked == true)
    window.open('piechart.html',"_self");
  else if (rd2.checked == true)
    window.open('barchart.html',"_self");
}
	
function fn2() {
  var fc1 = document.getElementById('fc1');
  var fc2 = document.getElementById('fc2');

  if (fc1.checked == true)
    window.open('frdaybr.html',"_self");
  else if (fc2.checked == true)
    window.open('frbarchart.html',"_self");
}