document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const getProfileButton = document.querySelector("#getProfile")
  // 他のメソッドを実行できるようになるための作業
  liff.init({
    liffId: "1655592642-mxP7Mkkp"
  })
  .then(() => {
    if (!liff.isLoggedIn()) {
      liff.login();
    }
  })
  .catch((err) => {
    console.log(err.code, err.message);
  });

  getProfileButton.addEventListener('click', () => {
    // idTokenからユーザーIDを取得する
    const idToken = liff.getIDToken()
    console.log(idToken)
    const body =`idToken=${idToken}`
    const request = new Request('/users', {
      headers: {
        // application/x-www-form-urlencoded; charset=utf-8 => ブラウザからPOSTリクエストを送信する場合のデフォルトのContent-Type
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'X-CSRF-Token': token
      },
      method: 'POST',
      body: body
    });
    fetch(request)
    .then(response => response.json())
    .then(data => console.log(data))

    // フォームの内容をpostしてokが返ってきたらshareTargetPickerを開く
    const form = document.querySelector('.form')
    const schedule = new FormData(form)
    fetch('/schedules', {
      method: 'POST',
      body: schedule,

    })
    .then((response) => {
      if(!response.ok) {
        console.log('error!');
      }else{
        liff.shareTargetPicker([
          {
          'type': 'text',
          'text': 'デートのお誘いです'
          },
          {
          'type': 'text',
          'text': 'schedules#showページのURL'
          }
        ])
        .then(function(res) {
          if (res) {
            // TargetPickerが送られたら
            console.log(`[${res.status}] Message [${this.msgType}] is sent!`)
            liff.closeWindow();
          } else {
            // TargetPickerを送らずに閉じたら
            console.log('TargetPicker was closed!')
            liff.closeWindow();
          }
        }).catch(function(error) {
          // TargetPickerを開く前にエラーが出たら
          console.log('something wrong happen')
        })
        console.log('ok!');
        response.json();
      }
    }).then((data)  => {
      console.log(data);
    }).catch((error) => {
      console.log(error);
    });
  })
})