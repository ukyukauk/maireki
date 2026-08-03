// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import $ from 'jquery'

document.addEventListener('turbo:load', () => {
  const addButton = $("#add-row-button");
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

  $(document)
    .off("click.removeItem", "#remove-row-button")
    .on("click.removeItem", "#remove-row-button", function (e) {
      e.preventDefault();

      const $row = $(this).closest(".item-inputs");
      const $visibleRows = $container.find(".item-inputs:visible");
      const itemId = $row.find("input[name$='[id]']").val();
      const $destroyField = $row.find(".destroy-field");

      if (itemId) {
        // DB保存済み
        $destroyField.val("1");
        $row.hide();
      } else {
        // まだDBに保存されていない追加行
        $row.remove();
      }

      updateSelectValidation();
    });
});
