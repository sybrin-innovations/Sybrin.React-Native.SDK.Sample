import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

// Imports needed for the example to work:

// Import to make use of Buttons
import { Button } from 'react-native'

// Imports related to our Swift class. The name MUST be the exact same as specified on the Native Swift side.
import { NativeModules } from 'react-native';
const { SDKRunner } = NativeModules;

export default function App() {
  return (
    <View style={styles.container}>

      {/* Button used to call native method */}
      <Button
        title="Scan!"
        onPress={() =>

          // Call method from Swift and wait for the callback response
          SDKRunner.scan((result) => {
              console.log("======| " + result + " |======")
            })
        }
      />
    </View>
  );
}


const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
