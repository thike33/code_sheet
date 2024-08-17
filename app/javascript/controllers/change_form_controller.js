import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["formCode"];
  codeId = document.querySelectorAll('.js-form-code').length;
  maxForms = 3;

  add() {
    const currentFormsCount = document.querySelectorAll('.js-form-code').length;

    if (currentFormsCount >= this.maxForms) {
      alert('これ以上追加できません。');
      return;
    }

    this.codeId++;
    let codeFormElement = document.createElement('div');
    codeFormElement.innerHTML = `
      <div class="relative mt-5 md:mt-10 js-code">
        <div class="relative">
          <div class="js-form-code">
            <div class="flex flex-col items-start gap-2">
              <label class="inline-block text-base md:text-lg" for="post_codes_attributes_${this.codeId}_language">言語</label>
              <select class="p-4 text-base" name="post[codes_attributes][${this.codeId}][language]" id="post_codes_attributes_${this.codeId}_language">
                <option selected="selected" value="html">HTML</option>
                <option value="css">CSS</option>
                <option value="javascript">JavaScript</option>
                <option value="ruby">Ruby</option>
                <option value="php">PHP</option>
              </select>
            </div>
            <div class="mt-5 md:mt-10">
              <label class="inline-block text-base md:text-lg required" for="post_codes_attributes_${this.codeId}_body">コード</label>
              <textarea class="block mt-2 w-full min-h-[400px] p-2" name="post[codes_attributes][${this.codeId}][body]" id="post_codes_attributes_${this.codeId}_body"></textarea>
            </div>
          </div>
          <input type="hidden" name="post[codes_attributes][${this.codeId}][_destroy]" value="false" class="destroy-flag">
          <button type="button" data-action="click->change-form#remove" class="inline-block absolute bottom-[400px] right-0 rounded max-w-[90px] w-full p-2 bg-red-500 text-white text-sm font-bold text-center cursor-pointer">コード削除</button>
        </div>
      </div>
    `;
    const codeElements = document.querySelectorAll('.js-code');
    const lastCodeElement = codeElements[codeElements.length - 1];
    lastCodeElement.appendChild(codeFormElement);
  }

  remove(event) {
    const destroyFlag = event.currentTarget.previousElementSibling;
    const formCodes = document.querySelectorAll('.js-form-code');
    const formCodeElement = event.currentTarget.closest('.js-code').querySelector('.js-form-code');

    if (formCodes.length <= 1) {
      alert('これ以上削除できません。');
      return;
    }

    if (destroyFlag) {
      destroyFlag.value = 'true';
      event.currentTarget.remove();
      formCodeElement.remove();
    }
  }
}
