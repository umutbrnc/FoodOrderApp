# FoodOrderApp
Food Order Mobile Application (iOS) with Swift

Food Order Application is an application where the user can see the products and perform the operations of adding to the cart, deleting from the cart and updating the quantity.
Note : This application was made as a graduation project within the framework of the iOS Lab development bootcamp within techcareer.net, thanks to the valuable information taught by Kasım Adalan.

Technologies used:
Firebase Authentication ; was used for registration.
Alamofire ; was used to fetch data from apidean.
RxSwift ; was used to monitor changes in data.
Kingfisher ; was used to retrieve food images from the API and display them on the screen. Also the project was designed in accordance with the Model-View-ViewModel Architecture.

<img width="200" alt="Entry" src="https://github.com/umutbrnc/FoodOrderApp/assets/117451508/3c40c4be-cd4a-443c-b780-27b23b707274">
<img width="200" alt="SignUp" src="https://github.com/umutbrnc/FoodOrderApp/assets/117451508/f842d723-65b4-4dfa-b40d-477edf7ffa57">
<img width="200" alt="Login" src="https://github.com/umutbrnc/FoodOrderApp/assets/117451508/dfd2c836-6aae-4c84-a5ee-c83f8311b1e2">
<img width="200" alt="Profile" src="https://github.com/umutbrnc/FoodOrderApp/assets/117451508/ec1ff37d-1678-4446-8e17-8fa53ff87262">
<img width="200" alt="Products" src="https://github.com/umutbrnc/FoodOrderApp/assets/117451508/a29ceaab-0ef6-446f-9dd7-3a06cfb80cc1">
<img width="200" alt="Details" src="https://github.com/umutbrnc/FoodOrderApp/assets/117451508/8d412ce1-391b-46c6-9338-351407afa851">
<img width="200" alt="Basket" src="https://github.com/umutbrnc/FoodOrderApp/assets/117451508/ece3ed78-9329-4691-a983-1da0f5c78add">

At the beginning, a login signup page welcomes us. Some login and sign-up operations are carried out via firebase auth.

 The data coming from the API is listed on a products page, in this area the product can be added to the cart. When you click on the product, the detail page comes up and the desired quantity can be selected from there and added to the cart. You can also search by product name.

Then, the products in the basket belonging to the relevant username are listed on the basket page. The product quantity for the products in the basket can be updated and the product can be deleted from the basket.

On the profile page, the user information of the current user is displayed and the user can be logged out with the logout button. If the user does not log out, he/she is directed directly to the home page as logged in when the application is first launched.
