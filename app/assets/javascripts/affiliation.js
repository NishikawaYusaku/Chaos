document.addEventListener("turbolinks:load", function() {
  const affiliationIndividual = document.getElementById("affiliation_individual");
  const affiliationCompany = document.getElementById("affiliation_company");
  const affiliationNameField = document.getElementById("affiliation_name");

  if (affiliationNameField.value === "") {
    affiliationCompany.checked = false;
  }
  
  // 「企業（グループなど）」がチェックされている場合、テキストボックスを表示
  if (affiliationCompany.checked) {
    affiliationNameField.style.display = "block";
  } else {
    affiliationNameField.style.display = "none";
  }

  // 「企業（グループなど）」を選択するとテキストフィールドを表示
  affiliationCompany.addEventListener("change", function() {
    affiliationNameField.value = "";
    affiliationNameField.style.display = "block";
    affiliationNameField.focus(); // テキストボックスにフォーカスを設定
  });

  // 「個人」を選択するとテキストフィールドを非表示にし、値に「個人」を指定
  affiliationIndividual.addEventListener("change", function() {
    affiliationNameField.style.display = "none";
    affiliationNameField.value = "個人"; // テキストボックスの値をリセット
  });
});