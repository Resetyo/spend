import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const search = new URLSearchParams(window.location.search);
    if(search.get('spend_id')) { this.openModal('spendModal') }
    if(search.get('category_id')) { this.openModal('categoryModal') }
    if(search.get('source_id')) { this.openModal('sourceModal') }

    const self = this;
    const modalBtns = document.querySelectorAll('[data-toggle="modal"]');

    modalBtns.forEach((btn) => {
      btn.addEventListener("click", function() {

        const target = this.getAttribute('data-target');
        self.openModal(target);
      });
    });

    const modaWrapperlBtns = document.querySelectorAll('.modal-wrapper');

    modaWrapperlBtns.forEach((btn) => {
      btn.addEventListener("click", function(event) {
        if(event.target === this) {
          this.style.opacity = 0;
          document.querySelector('body').style.overflow = null;

          setTimeout(() => {
            this.classList.remove('visible');
          }, 1000);
        }
      });
    });
  }

  openModal(target) {
    const modal = document.querySelector(`#${target}`);
    modal.classList.add('visible');

    setTimeout(() => {
      modal.style.opacity = 1;
    }, 100);
  }
}
