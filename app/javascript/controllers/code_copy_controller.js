import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["code"];

  copy(event) {
    const buttonElement = event.currentTarget;
    const codeElement = buttonElement.closest('.code-container').querySelector('code');
    const codeText = codeElement.innerText;

    navigator.clipboard.writeText(codeText).then(() => {
      alert("コードをコピーしました！");
    }).catch(error => {
      console.error('Failed to copy: ', error);
    });
  }
}
