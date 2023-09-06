import { useState } from "react";
import { Keyboard, View, Text, StyleSheet, Button, Alert } from "react-native";
import { TextInput } from "react-native-gesture-handler";

export default function TodoModalContent({ id, title }) {
  const [email, setEmail] = useState("");
  const [focus, setFocus] = useState(false);

  const handleSubmit = async () => {
    const response = await fetch("http://192.168.0.6:8080/todos/shared_todos", {
      headers: {
        "Content-Type": "application/json",
      },
      method: "POST",
      body: JSON.stringify({
        todo_id: id,
        user_id: 1, //hard coded value (user 1)
        email: email, // hard coded value (user 2)
      }),
    });
    const data = await response.json();
    console.log(data);
    Keyboard.dismiss();
    setEmail("");
    setFocus(false);
    Alert.alert(
      "Congratulations 🎉",
      `You successfully shared ${title} with ${email}`,
      [{ text: "Okay" }]
    );
  };

  return (
    <View style={styles.contentContainer}>
      <Text style={[styles.title, { marginBottom: 20 }]}>Compartí la tarea</Text>
      <Text style={[styles.title, { marginBottom: 20 }]}>"{title}"</Text>
      <Text style={styles.description}>
        Ingresá el correo electrónico del usuario con el que deseas compartir tu tarea. Compartí una
        tarea con alguien y mantengan sincronizados sus objetivos todos los días.
      </Text>
      <TextInput
        value={email}
        onChangeText={(text) => setEmail(text.toLowerCase())}
        onFocus={() => setFocus(true)}
        onBlur={() => setFocus(false)}
        keyboardType="email-address"
        style={[
          styles.input,
          focus && { borderWidth: 3, borderColor: "black" },
        ]}
        placeholder="Ingresa email de tu contacto"
      />
      <Button
        onPress={handleSubmit}
        title="Compartir"
        disabled={email.length === 0}
      />
    </View>
  );
}
const styles = StyleSheet.create({
  contentContainer: {
    flex: 1,
    paddingHorizontal: 15,
  },
  title: {
    fontWeight: "900",
    letterSpacing: 0.5,
    fontSize: 16,
    textAlign: "center",
  },
  description: {
    color: "#56636F",
    fontSize: 13,
    fontWeight: "normal",
    width: "100%",
  },
  input: {
    borderWidth: 2,
    borderColor: "#00000020",
    padding: 15,
    borderRadius: 15,
    marginVertical: 15,
  },
});