part of 'constants.dart';

class SnippetsList {
  final List<Snippet> snippets;
  SnippetsList({
    required this.snippets,
  });
}

class Snippet {
  final String title;
  final String description;
  final String code;

  Snippet({
    required this.title,
    required this.description,
    required this.code,
  });
}

const List<Map<String, String>> snippetsConstEs = [
  {
    "title": "Ejemplo de la clase del contrato para Almacenar Mensaje.",
    "description": "",
    "code": _snippet01es,
  },
  {
    "title": "Ejemplo de contrato para Almacenar mensajes.",
    "description": "",
    "code": _snippet02es,
  },
  {
    "title": "Ejemplo del contrato para recuperar los mensajes guardados",
    "description": "",
    "code": _snippet03es,
  },
  {
    "title": "Ejemplo de archivo config para configurar en diferentes redes.",
    "description": "",
    "code": _snippet04es,
  },
  {
    "title": "Ejemplo Frontend sencillo usando el archivo config.",
    "description": "",
    "code": _snippet05es,
  },
  {
    "title": "Desplegando el contrato inteligente.",
    "description": "",
    "code": _snippet06es,
  }
];

const String _snippet01es =
    '''assembly/model.ts
import { context, u128, PersistentVector } from "near-sdk-as";

@nearBindgen
export class PostedMessage {
  premium: boolean;
  sender: string;
  constructor(public text: string) {
    this.premium = context.attachedDeposit >= u128.from('10000000000000000000000');
    this.sender = context.sender;
  }
}
export const messages = new PersistentVector&lt<PostedMessage>("m");

// @nearBindgen marca la clase como serializable, les daremos ciertas “capacidades” a las clases marcadas. 
Las 3 features que tiene esta clase son:
“premium” para incluir NEAR tokens a los mensajes.
“sender” para rastrear el firmante del mensaje.
“test” para almacenar el mensaje.

“messages” es una colección de mensajes almacenados como un PersistentVector de objetos PostedMessage.
''';
const String _snippet02es =
    '''assembly/main.ts
import { PostedMessage, messages } from './model';
// --- contract code goes below
// El número máximo de mensajes pasados que el contrato retornará.
const MESSAGE_LIMIT = 10;
/**
* Añade un nuevo mensaje debajo del nombre de la cuenta que envía.\
* Este es un método que modifica el estado.\
 */
export function addMessage(text: string): void {
// Creando un nuevo mensaje y llenando los campos con nuestros datos
  const message = new PostedMessage(text);
// Añade el mensaje al final de la colección persistente.
  messages.push(message);
}
// “MESSAGE_LIMIT” es una constante usada para evitar llamadas muy largas, y potencialmente caras.
''';
const String _snippet03es =
    '''assembly/main.ts
import { PostedMessage, messages } from './model';
/**
 * Retorna un arreglo de los ultimos N mensajes.\
 * Es un metodo que no debe modificar el estado.\
 */
export function getMessages(): PostedMessage[] {
  const numMessages = min(MESSAGE_LIMIT, messages.length);
  const startIndex = messages.length - numMessages;
  const result = new Array&lt;PostedMessage&gt;(numMessages);
  for(let i = 0; i <  numMessages; i++) {
    result[i] = messages[i + startIndex];
  }
  return result;
}
''';

const String _snippet04es =
    '''src/config.js
const CONTRACT_NAME = process.env.CONTRACT_NAME || 'guest-book.testnet';
function getConfig(env) {
  switch(env) {
    case 'mainnet':
      return {
        networkId: 'mainnet',
        nodeUrl: 'https://rpc.mainnet.near.org',
        contractName: CONTRACT_NAME,
        walletUrl: 'https://wallet.near.org',
        helperUrl: 'https://helper.mainnet.near.org'
      };
    // Es un app de ejemplo, así que “production” está puesto en testnet.
    // Puedes cambiarlo a mainnet si prefieres.
    case 'production':
    case 'development':
    case 'testnet':
      return {
        networkId: 'default',
        nodeUrl: 'https://rpc.testnet.near.org',
        contractName: CONTRACT_NAME,
        walletUrl: 'https://wallet.testnet.near.org',
        helperUrl: 'https://helper.testnet.near.org'
      };
    case 'betanet':
      return {
        networkId: 'betanet',
        nodeUrl: 'https://rpc.betanet.near.org',
        contractName: CONTRACT_NAME,
        walletUrl: 'https://wallet.betanet.near.org',
        helperUrl: 'https://helper.betanet.near.org'
      };
    case 'local':
      return {
        networkId: 'local',
        nodeUrl: 'http://localhost:3030',
        keyPath: \`\$\{process.env.HOME\}/.near/validator_key.json`,
        walletUrl: 'http://localhost:4000/wallet',
        contractName: CONTRACT_NAME
      };
    case 'test':
    case 'ci':
      return {
        networkId: 'shared-test',
        nodeUrl: 'https://rpc.ci-testnet.near.org',
        contractName: CONTRACT_NAME,
        masterAccount: 'test.near'
      };
    case 'ci-betanet':
      return {
        networkId: 'shared-test-staging',
        nodeUrl: 'https://rpc.ci-betanet.near.org',
        contractName: CONTRACT_NAME,
        masterAccount: 'test.near'
      };
    default:
      throw Error(`Unconfigured environment '\${env}'. Can be configured in src/config.js.`);
  }
}
module.exports = getConfig;
Este codigo define los datos y endpoints requeridos para conectarse a la red de NEAR.
''';
const String _snippet05es =
    '''src/index.js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import getConfig from './config.js';
import * as nearAPI from 'near-api-js';
// Inicializando el contracto
async function initContract() {
  const nearConfig = getConfig(process.env.NODE_ENV || 'testnet');
  // Iniciando conexión a la NEAR TestNet
  const near = await nearAPI.connect({
    deps: {
      keyStore: new nearAPI.keyStores.BrowserLocalStorageKeyStore()
    },
    ...nearConfig
  });
  // Necesita acceso a la wallet.
  const walletConnection = new nearAPI.WalletConnection(near);
  // Carga los datos de la cuenta.
  let currentUser;
  if(walletConnection.getAccountId()) {
    currentUser = {
      accountId: walletConnection.getAccountId(),
      balance: (await walletConnection.account().state()).amount
    };
  }
  // Inicializando nuestro contrato API por su nombre y configuración
  const contract = await new nearAPI.Contract(walletConnection.account(), nearConfig.contractName, {
    // Los metodos View son de solo lectura, no modifican el estado, pero generalmente retornan algún
    viewMethods: ['getMessages'],
    // Los metodos Change si modifican el estado, pero no retornan valor al ser llamados
    changeMethods: ['addMessage'],
    // Sender es el ID de la cuenta para inicializar transacciones.
    // getAccountId() retornará una String vacia si el usuario no está autorizado
    sender: walletConnection.getAccountId()
  });
  return { contract, currentUser, nearConfig, walletConnection };
}
window.nearInitPromise = initContract()
  .then(({ contract, currentUser, nearConfig, walletConnection }) =&gt; {
    ReactDOM.render(
      &lt;App
        contract={contract}
        currentUser={currentUser}
        nearConfig={nearConfig}
        wallet={walletConnection}
      /&gt;,
      document.getElementById('root')
    );
  });
Esta es la principal parte del frontend, es donde se configura la conexión a la red NEAR.
''';
const String _snippet06es =
    '''Desplegar el contrato inteligente:
npm install –global near-cli
near –version
//En este punto debes crearte una cuenta de NEAR WALLET y autorizarlo en NEAR CLI
near login
//Modifica una línea en src/config.js
const CONTRACT_NAME = process.env.CONTRACT_NAME || ‘tu cuenta aquí’
yarn deploy
''';
