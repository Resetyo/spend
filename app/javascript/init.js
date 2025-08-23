document.addEventListener("DOMContentLoaded", function () {
  const claseBtns = document.querySelectorAll('.flash-close');

  claseBtns.forEach((btn) => {
    btn.addEventListener("click", function() {
      this.parentNode.remove();
    });
  });
});
