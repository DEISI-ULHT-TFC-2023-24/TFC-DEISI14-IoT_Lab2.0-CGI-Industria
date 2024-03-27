import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// Definindo o cliente MQTT apontando para o broker de teste e deixando o clientId vazio para ser gerado automaticamente.
final client = MqttServerClient('localhost', 'Mqtt_MyClientUniqueId');

// Variável para contar quantas vezes recebemos um 'pong' do broker.
var pongCount = 0;

// Método principal async para executar o cliente MQTT.
Future<int> main() async {
  // Configurações iniciais do cliente.
  client.logging(on: true); // Habilita o log.
  client.setProtocolV311(); // Define o protocolo MQTT 3.1.1.
  client.keepAlivePeriod = 20; // Define o período de keep-alive.
  client.connectTimeoutPeriod = 2000; // Define o tempo de timeout para a conexão.

  // Definindo callbacks para diferentes eventos.
  client.onDisconnected = onDisconnected; // Callback para quando o cliente se desconectar.
  client.onConnected = onConnected; // Callback para quando o cliente se conectar com sucesso.
  client.onSubscribed = onSubscribed; // Callback para quando uma subscrição for confirmada.
  client.pongCallback = pong; // Callback para quando receber um 'pong' do broker.

  // Preparando a mensagem de conexão.
  final connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueId') // Define o identificador do cliente.
      .startClean() // Inicia uma sessão limpa.
      .withWillQos(MqttQos.atLeastOnce); // Define o QoS do testamento.
  client.connectionMessage = connMess;

  // Tentando conectar ao broker MQTT.
  try {
    await client.connect();
  } catch (e) { // Tratamento de erros de conexão.
    print('Erro ao conectar: $e');
    client.disconnect();
    exit(-1); // Sai do programa se não conseguir conectar.
  }

  // Verificando se a conexão foi bem-sucedida.
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('Conectado ao broker MQTT.');
  } else {
    print('Falha na conexão com o broker.');
    client.disconnect();
    exit(-1);
  }

  // Se inscrevendo em um tópico.
  const topic = 'test/lol';
  client.subscribe(topic, MqttQos.atMostOnce);

  // Ouvindo por atualizações nos tópicos subscritos.
  client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    print('Mensagem recebida: $pt');
  });

  // Publicando uma mensagem em um tópico.
  const pubTopic = 'Dart/Mqtt_client/testtopic';
  final builder = MqttClientPayloadBuilder();
  builder.addString('Hello from mqtt_client');
  client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

  // Aguardando mensagens por um tempo.
  print('Aguardar as mensagens...');
  await MqttUtilities.asyncSleep(60);

  // Desinscrevendo do tópico e desconectando do broker.
  print('Desinscrevendo e desconectando...');
  client.unsubscribe(topic);
  client.disconnect();
  print('Saindo...');
  return 0; // Retorna 0 indicando a saída normal do programa.
}

// Callback para confirmação de subscrição.
void onSubscribed(String topic) {
  print('Inscrito no tópico $topic');
}

// Callback para desconexao.
void onDisconnected() {
  print('Cliente desconectado');
  if (pongCount == 3) {
    print('Contagem de pong correta');
  } else {
    print('Contagem de pong incorreta: $pongCount');
  }
}

// Callback para conexão bem-sucedida.
void onConnected() {
  print('Conectado com sucesso ao broker');
}

// Callback para resposta de ping (pong).
void pong() {
  print('Pong recebido do broker');
  pongCount++; // Incrementa a contagem de pong.
}
