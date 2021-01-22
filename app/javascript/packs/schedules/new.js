window.addEventListener('load', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const getProfileButton = document.querySelector("#getProfile")
  const sub_field = document.querySelector("#sub")
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
    let idToken = liff.getIDToken()
    console.log(idToken)
    let body =`idToken=${idToken}`
    let request = new Request('/schedules', {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'X-CSRF-Token': token
      },
      method: 'POST',
      body: body
    });
    fetch(request)
    .then(response => response.json())
      .then(data => {
         console.log(data)
         sub_field.append(data.sub)
        })

  })
})