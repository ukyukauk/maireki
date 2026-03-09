// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import $ from 'jquery'

document.addEventListener('turbo:load', () => {
  const addButton = $("#add-row-button");
  const removeButton = $("#remove-row-button");
  const $container = $(".item-container");
  const $template = $("#item-template");

  // 未入力selectに赤枠をつける
  const updateSelectValidation = () => {
    $container.find(".item-inputs select").each(function () {
      const $select = $(this);
      if ($select.val() === "" || $select.val() == null) {
        $select.addClass("is-invalid");
      } else {
        $select.removeClass("is-invalid");
      }
    });
  };

  // selectが変更されたら赤枠を外す/付ける
  $(document).on("change", ".item-inputs select", () => {
    updateSelectValidation();
  });

  // 追加ボタン
  addButton.on("click", (e) => {
    e.preventDefault();

    updateSelectValidation();

    // すべてのselectに値があるか確認
    let allSelected = true;

    $(".item-inputs select").each(function () {
      if ($(this).val() === "") {
        allSelected = false;
      }
    });

    if (!allSelected) return;

    // 入力欄追加
    const time = Date.now();
    const html = $template.html().replace(/NEW_RECORD/g, time);
    $container.append(html);

    updateSelectValidation();
  });

  // 削除ボタン
  removeButton.on("click", (e) => {
    e.preventDefault();

    const $inputs = $container.find(".item-inputs");

    if ($inputs.length <= 1) return;

    $inputs.each(function () {
      const input = $(this);

      const select = input.find("select").val();
      const name = input.find("input[type='text']").val();
      const price = input.find("input[type='number']").val();

      // 全部空なら削除
      if (!select && !name && !price) {
        input.remove();
        return false; // 1行だけ削除して終了
      }
    });

    updateSelectValidation();
  });
});
