document.addEventListener('DOMContentLoaded', function(){
  // 新規投稿・編集ページのフォームを取得
  const createForm = document.getElementById('new_create');
  // プレビューを表示するためのスペースを取得
  const previewList = document.getElementById('previews');
  // 新規投稿・編集ページのフォームがないならここで終了。「!」は論理否定演算子。
  if (!createForm) return null;
  
  // input要素を取得。name情報は検証ツールから確認すること！！
  const fileField = document.querySelector('input[type="file"][name="vtuber[image]"]');
  // input要素で値の変化が起きた際に呼び出される関数
  fileField.addEventListener('change', function(e){
    // 古いプレビューが存在する場合は削除(最後に記述する)
    const alreadyPreview = document.querySelector('.preview');
    if (alreadyPreview) {
      alreadyPreview.remove();
    };
    // 取得した画像ファイルの情報は、変数fileに格納する
    const file = e.target.files[0];
    // 取得した画像情報のURLを生成(生成されたURLはblobという変数に代入)
    const blob = window.URL.createObjectURL(file);
    // 画像を表示するためのdiv要素を生成
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');
    // 表示する画像を生成
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'mt-3 rounded-circle border border-dark');
    previewImage.setAttribute('width', '250');
    previewImage.setAttribute('height', '250');
    // setAttributeメソッドを用いて生成したimg要素のsrc属性へ変数blobを設定する
    previewImage.setAttribute('src', blob);
    // 生成したHTMLの要素をブラウザに表示させる
    previewWrapper.appendChild(previewImage);
    previewList.appendChild(previewWrapper);
  });
});