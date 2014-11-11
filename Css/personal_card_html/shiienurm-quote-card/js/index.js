var pagPrev = document.getElementById("prev"),
    pagNext = document.getElementById("next"),
    pagCount = document.getElementById("pagination-count"),
    heart = document.getElementById("heart");

next.addEventListener("click", function() {
  slide();
}, false);
prev.addEventListener("click", function() {
  slide();
}, false);
heart.addEventListener("click", function() {
  document.body.className += " like";
  setTimeout( function() {
    document.body.className = "";
  }, 1000 );
}, false);

function slide() {
  if (document.body.classList.contains("slide")) {
    document.body.className = "";
    pagCount.textContent = "25 of 56"
  } else {
    document.body.className += " slide";
    pagCount.textContent = "26 of 56"
  }
}