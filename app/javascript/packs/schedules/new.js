window.addEventListener('load', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const getProfileButton = document.querySelector("#getProfile")
  const iss_field = document.querySelector("#iss")
  const sub_field = document.querySelector("#sub")
  const aud_field = document.querySelector("#aud")
  const exp_field = document.querySelector("#exp")
  const iat_field = document.querySelector("#iat")
  const authTime_field = document.querySelector("#authTime")
  const nonce_field = document.querySelector("#nonce")
  const amr_field = document.querySelector("#amr")
  const name_field = document.querySelector("#name")
  const picture_field = document.querySelector("#picture")
  const email_field = document.querySelector("#email")
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
         iss_field.append(data.iss)
         sub_field.append(data.sub)
         aud_field.append(data.aud)
         exp_field.append(data.exp)
         iat_field.append(data.iat)
         authTime_field.append(data.auth_time)
         nonce_field.append(data.nonce)
         amr_field.append(data.amr)
         name_field.append(data.name)
         picture_field.append(data.picture)
         email_field.append(data.email)
        })

  })
})