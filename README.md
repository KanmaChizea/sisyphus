# sisyphus

A Flutter application that implements the Binance WebSockets API for Candlestick and Orderbooks with an interactive UI based on the provided design.

## Demo

![App Demo](https://drive.google.com/drive/folders/16K3nCL15QZlGn0G2b-yaNyr2-RXIP_02?usp=sharing)

## Features

- Real-time cryptocurrency price tracking
- Interactive candlestick chart
- Live orderbook data
- Support for multiple cryptocurrency pairs
- Dark mode UI

## Technologies Used

- Flutter for cross-platform mobile development
- Binance WebSockets API for real-time data
- Bloc for state management
- Echarts for rendering trading charts

## Setup Instructions

1. Clone the repository:

```bash
git clone https://github.com/your-username/your-repo-name.git
```

2. Navigate to the project directory:

```bash
cd sisyphus
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the application:

```bash
flutter run
```

## Project Structure

lib/
├── core/
│   ├── constants/
│   └── dependency_injection/
├── models/
│   ├── candle.dart
│   └── order_book.dart
│   └── order.dart
│   └── ticker.dart
├── navigation/
│   └── navigation_service.dart
│   └── routes.dart
├── screens/
│   ├── buy_sell/
│   │    ├── buy_sell_state.dart
│   │    ├── buy_sell_view.dart
│   │    ├── buy_sell_viewmodel.dart
│   ├── home/
│   │    ├── chart_state.dart
│   │    ├── orderbook_state.dart
│   │    ├── home_state.dart
│   │    ├── home_viewmodel.dart
│   │    ├── home_view.dart
├── services/
│   ├── binance_interface.dart
│   ├── binance_service.dart
├── theme/
│   ├── colors.dart
│   ├── extension.dart
├── utils/
│   ├── extensions/
│   ├── helpers/
│   ├── viewmodel/
├── widgets/
│   ├── shared/
│   ├── home/
└── main.dart

## Implementation Details

### Binance WebSocket Implementation

The application connects to the Binance WebSocket API to receive real-time data:

- Candlestick data is received through the `wss://fstream.binance.com/ws/btcusdt@kline_1m` endpoint
- Orderbook data is received through the `ws://dstream.binance.com/ws/btcusdt@depth` endpoint

### UI Implementation

The UI closely follows the provided Figma design with the following components:

- Top navigation bar with cryptocurrency selection
- Candlestick chart with time interval selection
- Buy/Sell modal
- Orderbook display showing bid and ask orders

## Challenges and Solutions

- **Binance API Accessibility**: One significant challenge was that the Binance website and APIs require a VPN to be accessible in certain regions due to geo-restrictions. This was resolved by implementing a VPN connection during development and testing. For production readiness, the app includes a network status checker that alerts users if they need to connect to a VPN to access real-time data.

- **Candlestick Chart Customization**: Finding a Flutter package for candlestick charts that was customizable enough to match the Figma design was particularly challenging. After evaluating several options, I ultimately solved this by implementing ECharts, which allowed me to convert JSON data directly into the chart. This approach provided the flexibility needed to achieve the visual style and interactive elements specified in the Figma design while maintaining good performance.
