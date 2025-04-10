# Archethic Providers

This folder contains essential providers for interacting with the Archethic blockchain.

## Main Providers

- `apiServiceProvider` - Provides an API service to communicate with Archethic nodes
- `environmentProvider` - Provides the current environment (mainnet, testnet, devnet)
- `dappClientProvider` - Provides a client for connecting to the Archethic wallet
- `isAppEmbeddedProvider` - Detects if the application is embedded in another app via URL parameters

## Setup Requirements

### Platform Configuration

#### Android

Add the following to your `AndroidManifest.xml`:

```xml
<!-- For wallet integration -->
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data
            android:scheme="aewallet"
            android:host="archethic.tech" />
    </intent>
</queries>

<!-- Inside activity tag with .MainActivity name -->
<meta-data
    android:name="flutter_deeplinking_enabled"
    android:value="true" />
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="YOUR_APP_SCHEME"  
        android:host="YOUR_APP_HOST" />
</intent-filter>
```

#### iOS

Add to your `Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>aewallet</string>
</array>

<key>FlutterDeepLinkingEnabled</key>
<true/>
<key>CFBundleURLTypes</key>
<array>
    <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>YOUR_APP_HOST</string>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>YOUR_APP_SCHEME</string>
    </array>
    </dict>
</array>
```

#### macOS

Add to `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`:

```xml
<key>com.apple.security.network.client</key>
<true/>
```

## Usage

### apiServiceProvider

This provider offers an instance of Archethic's `ApiService` configured with the current environment.

```dart
final apiService = ref.watch(apiServiceProvider);

// Get transaction information
final transaction = await apiService.getTransaction(['ADDRESS']);

// Get transaction chain information
final chain = await apiService.getTransactionChain({'ADDRESS': ''});

// Send a transaction
final txResult = await apiService.sendTx(transaction);

// Get transaction fee
final fee = await apiService.getTransactionFee(tx);

// Get transaction index
final indexMap = await apiService.getTransactionIndex(['ADDRESS']);
final index = indexMap['ADDRESS'];

// Get the last transaction in a chain
final transactionMap = await apiService.getLastTransaction(['ADDRESS']);
final lastTx = transactionMap['ADDRESS'];

// Get the storage nonce public key
final storageNoncePublicKey = await apiService.getStorageNoncePublicKey();

// Get origin key
final originPrivateKey = await apiService.getOriginKey();
```

### Transaction Building

Using the ApiService, you can create and send transactions to the Archethic blockchain:

```dart
// Create a new transaction
final tx = Transaction(type: 'transfer', data: Transaction.initData())
  .addUCOTransfer('RECIPIENT_ADDRESS', toBigInt(0.42))
  .build('YOUR_SEED', 0, 'P256')
  .transaction;

// Sign with origin key
final originPrivateKey = await apiService.getOriginKey();
tx.originSign(originPrivateKey);

// Send transaction
final txResult = await apiService.sendTx(tx);
```

For smart contract interactions:

```dart
// Add code to a smart contract (before transaction version 4)
tx.setCode("YOUR_SMART_CONTRACT_CODE");

// Add contract (after transaction version 4)
tx.setContract({
  'bytecode': bytecode,
  'manifest': manifest,
});

// Call a smart contract
tx.addRecipient(
  'CONTRACT_ADDRESS',
  'actionName',
  ['arg1', 'arg2'],
);
```

### environmentProvider

This provider gives access to the current Archethic environment (from the session).

```dart
final environment = ref.watch(environmentProvider);

// Use the environment to determine endpoints
final endpoint = ArchethicConfig.getEndpoint(environment);
final explorerUrl = ArchethicConfig.getExplorerUrl(environment);
```

### dappClientProvider

This provider offers a client to interact with the Archethic wallet:

```dart
final dappClient = await ref.watch(dappClientProvider.future);

// Connect to the wallet
await dappClient.connect();

// Get current account
final currentAccount = await dappClient.getCurrentAccount().valueOrNull;

// Subscribe to account updates
final subscription = await dappClient.subscribeCurrentAccount();

// Handle account updates
subscription.when(
  success: (subscription) {
    subscription.updates.listen((account) {
      // Update UI with account information
      print('Account changed: ${account.name}, ${account.genesisAddress}');
    });
  },
  failure: (error) {
    print('Failed to subscribe: ${error.message}');
  },
);

// Sign a transaction
final response = await dappClient.sendTransaction(tx.convertToJSON());
response.when(
  success: (result) {
    print('Transaction successful: ${result.transactionAddress}');
  },
  failure: (error) {
    print('Transaction failed: ${error.message}');
  },
);
```

### Deeplink Integration

If your app uses deeplinking for wallet integration, handle incoming links in your `MaterialApp`:

```dart
MaterialApp(
  // ...other properties
  onGenerateRoute: (settings) {
    // Handle deeplink responses for wallet integration
    if ((dappClient as DeeplinkArchethicDappClient).handleRoute(settings.name)) {
      return null; // Route handled by the wallet client
    }
    
    // Your other route handling logic
    return null;
  },
)
```

### isAppEmbeddedProvider

This provider detects if the app is embedded in another application via URL parameters:

```dart
final isEmbedded = ref.watch(isAppEmbeddedProvider);

// Use this flag to adjust your UI accordingly
if (isEmbedded) {
  // Simplified UI for embedded mode
} else {
  // Full UI for standalone mode
}
```

## Configuration Utilities

The `ArchethicConfig` utility in `lib/util/config/archethic_config.dart` provides helpful methods for working with different Archethic environments:

```dart
// Get endpoint for current environment
final endpoint = ArchethicConfig.getEndpoint(environment);

// Get explorer URL
final explorerUrl = ArchethicConfig.getExplorerUrl(environment);

// Generate transaction link
final txUrl = ArchethicConfig.getTransactionUrl(environment, txAddress);

// Generate address/chain link
final addressUrl = ArchethicConfig.getAddressUrl(environment, address);
```

## Keychain Utilities

The Archethic library provides keychain utilities for managing user keys and services:

```dart
// Check if a keychain exists for a given public key
final keychainExists = await KeychainUtil().checkKeychain(endpoint, publicKey);

// Get keychain addresses
final addresses = await KeychainUtil().keychainAddresses(endpoint, publicKey);

// Create a new keychain transaction
final keychainTx = await KeychainUtil().newKeychainTransaction(
  seed,
  authorizedPublicKeys,
  originPrivateKey,
);

// Create a keychain access transaction
final accessTx = await KeychainUtil().newAccessKeychainTransaction(
  seed,
  keychainAddress,
  originPrivateKey,
);

// Get a keychain from access seed
final keychain = await apiService.getKeychain(accessKeychainSeed);

// Derive address for a service
final address = keychain.deriveAddress('uco', index: 0);

// Derive keypair for a service
final keypair = keychain.deriveKeypair('uco', index: 0);

// Build a transaction using keychain
final tx = Transaction(type: 'transfer', data: Transaction.initData());
final signedTx = keychain.buildTransaction(tx, 'uco', index);
```

## Oracle Service

Get real-time data from the Archethic oracle service:

```dart
// Get oracle data (UCO price)
final oracleService = OracleService(endpoint);
final oracleData = await oracleService.getOracleData();
final eurRate = oracleData.uco?.eur;
final usdRate = oracleData.uco?.usd;

// Subscribe to oracle updates
oracleService.subscribeToOracleUpdates((data) {
  // Handle real-time oracle data updates
});
```

## Encryption Utilities

The Archethic crypto library provides encryption utilities:

```dart
// AES encryption
final encryptedData = crypto.aesEncrypt(
  'dataToEncrypt', 
  'symmetricKey',
  isDataHexa: false,
  isKeyHexa: false,
);

// EC key generation
final keypair = crypto.deriveKeyPair(
  'seed', 
  0, 
  curve: 'P256',
  isSeedHexa: false,
);
``` 