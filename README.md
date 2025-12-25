# CalorieGoal

***Calorie tracking app with goal-based validation system.***


<div align="center">
  <img width="400" height="400" alt="playstore" src="https://github.com/Cisco0xf/CalorieGoal-App/blob/main/assets/screenshots/flow_logo.png" />
<div align="center">

<p align="center">
   CalorieGoal | By Mahmoud Alshehyby
</p>

<div align="start">

## Features
- Personal calorie calculator (age, weight, height, gender)
- Browse meals from JSON database
- Add items with custom quantities
- Real-time calorie tracking
- Goal validation (unlock cart when target reached)
- API endpoint integration

## Tech Stack
- Flutter
- JSON parsing
- REST API
- Riverpod for State management

## Code Structure

```text
CalorieGoal/
│
└── lib/
    ├── commoms/
    │   ├── app_dimensions.dart
    │   ├── commons.dart
    │   ├── gaps.dart
    │   └── navigator_key.dart
    │
    ├── constants/
    │   ├── colors.dart
    │   ├── fonts.dart
    │   ├── paths.dart
    │   └── texts.dart
    │
    ├── data_layer/
    │   └── product_model.dart
    │
    ├── presentation_layer/
    │   ├── commons/
    │   │
    │   └── screens/
    │       ├── categories/
    │       │   ├── bottom_data.dart
    │       │   ├── food_item_screen.dart
    │       │   └── products_screen.dart
    │       │
    │       ├── order_summary/
    │       │   ├── cart_screen.dart
    │       │   └── finish_order.dart
    │       │
    │       ├── user_details/
    │       │   ├── commons/
    │       │   │   ├── details_field.dart
    │       │   │   └── select_gender.dart
    │       │   └── user_details_screen.dart
    │       │
    │       └── welcome_screen/
    │           └── welcome_screen.dart
    │
    ├── state_management_layer/
    │   ├── catch_data/
    │   │   └── catch_json_data.dart
    │   │
    │   ├── manage_user_details/
    │   │   ├── user_details.dart
    │   │   └── user_gender.dart
    │   │
    │   └── order_summary/
    │       ├── cart.dart
    │       └── post_confirmation.dart
    │
    └── main.dart
```

## Screenshots


<table>
   <tr>
    <td align="center"><b>Screen-1</b></td>
    <td align="center"><b>Screen-2</b></td>
    <td align="center"><b>Screen-3</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/CalorieGoal-App/blob/main/assets/screenshots/1.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/CalorieGoal-App/blob/main/assets/screenshots/2.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/CalorieGoal-App/blob/main/assets/screenshots/3.webp?raw=true" alt="Screen" width="300"/></td>
  </tr>
 

</table>

<table>
   <tr>
    <td align="center"><b>Screen-4</b></td>
    <td align="center"><b>Screen-5</b></td>
    <td align="center"><b>Screen-6</b></td>
     
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/CalorieGoal-App/blob/main/assets/screenshots/4.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/CalorieGoal-App/blob/main/assets/screenshots/5.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/CalorieGoal-App/blob/main/assets/screenshots/6.webp?raw=true" alt="Screen" width="300"/></td>
  </tr>
 

</table>

## License

**MIT © Mahmoud Nagy**

