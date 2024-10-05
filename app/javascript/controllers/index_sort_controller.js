import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['sort'];

  toggle() {
    const sortContent = document.querySelector('.js-sort-content');
    sortContent.classList.toggle('is-open');
  }

  remove() {
    const sortContent = document.querySelector('.js-sort-content');
    sortContent.classList.remove('is-open');
  }
}