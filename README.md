# FoodOrderApp
Food Order Mobile Application (iOS) with Swift

Food Order Application is an application where the user can see the products and perform the operations of adding to the cart, deleting from the cart and updating the quantity.
Note : This application was made as a graduation project within the framework of the iOS Lab development bootcamp within techcareer.net, thanks to the valuable information taught by Kasım Adalan.

Technologies used:
Firebase Authentication ; was used for registration.
Alamofire ; was used to fetch data from apidean.
RxSwift ; was used to monitor changes in data.
Kingfisher ; was used to retrieve food images from the API and display them on the screen.

At the beginning, a login signup page welcomes us. Some login and sign-up operations are carried out via firebase auth.

 The data coming from the API is listed on a products page, in this area the product can be added to the cart. When you click on the product, the detail page comes up and the desired quantity can be selected from there and added to the cart. You can also search by product name.

Then, the products in the basket belonging to the relevant username are listed on the basket page. The product quantity for the products in the basket can be updated and the product can be deleted from the basket.

On the profile page, the user information of the current user is displayed and the user can be logged out with the logout button. If the user does not log out, he/she is directed directly to the home page as logged in when the application is first launched.
