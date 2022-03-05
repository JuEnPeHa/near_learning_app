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
  },
  {
    "title": "Crear una cuenta nueva.",
    "description": "",
    "code": _snippet07es,
  },
  {
    "title": "Borrar una cuenta.",
    "description": "",
    "code": _snippet08es,
  },
  {
    "title": "Obtener balance de la cuenta.",
    "description": "",
    "code": _snippet09es,
  },
  {
    "title": "Obtener detalles de la cuenta, apps autorizadas y transacciones.",
    "description": "",
    "code": _snippet10es,
  },
  {
    "title": "Enviar NEAR tokens.",
    "description": "",
    "code": _snippet11es,
  },
  {
    "title": "Crear keyStore desde local storage",
    "description": "",
    "code": _snippet12es,
  },
  {
    "title": "Crear keyStore desde un archivo.",
    "description": "",
    "code": _snippet13es,
  },
  {
    "title": "Crear keyStore desde una String privada.",
    "description": "",
    "code": _snippet14es,
  },
  {
    "title": "Conectar a testnet.",
    "description": "",
    "code": _snippet15es,
  },
  {
    "title": "Conectar a mainnet.",
    "description": "",
    "code": _snippet16es,
  },
  {
    "title": "Conectar a betanet.",
    "description": "",
    "code": _snippet17es,
  },
  {
    "title": "Conectar a localnet.",
    "description": "",
    "code": _snippet18es,
  },
  {
    "title": "Conectar la Wallet a una app.",
    "description": "",
    "code": _snippet19es,
  },
  {
    "title": "Implementar el contrato de lista blanca.",
    "description": "",
    "code": _snippet20es,
  },
  {
    "title": "Revisando si un ID de cuenta existe en la lista blanca",
    "description": "",
    "code": _snippet21es,
  },
  {
    "title": "NFT: función: nft_total_supply",
    "description": "",
    "code": _snippet22es,
  },
  {
    "title": "NFT: función: nft_supply_for_owner",
    "description": "",
    "code": _snippet23es,
  },
  {
    "title": "NFT: función: nft_tokens_for_owner",
    "description": "",
    "code": _snippet24es,
  }
];

const String _snippet01es = '''assembly/model.ts
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
const String _snippet02es = '''assembly/main.ts
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
const String _snippet03es = '''assembly/main.ts
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

const String _snippet04es = '''src/config.js
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
const String _snippet05es = '''src/index.js
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
//Esta es la principal parte del frontend, es donde se configura la conexión a la red NEAR.
''';
const String _snippet06es = '''//Desplegar el contrato inteligente:
npm install –global near-cli
near –version
//En este punto debes crearte una cuenta de NEAR WALLET y autorizarlo en NEAR CLI
near login
//Modifica una línea en src/config.js
const CONTRACT_NAME = process.env.CONTRACT_NAME || ‘tu cuenta aquí’
yarn deploy
''';
const String _snippet07es =
    '''//Crea una nueva cuenta utilizando fondos de la cuenta utilizada para crearla.
const near = await connect(config);
const account = await near.account("example-account.testnet");
await account.createAccount(
  "example-account2.testnet", // nombre de la nueva cuenta
  "8hSHprDq2StXwMtNd43wDTXQYsjXcD4MJTXQYsjXcc", // clave publica de la nueva cuenta
  "10000000000000000000" // balance inicial de la cuenta nueva en yoctoNEAR
);''';
const String _snippet08es =
    '''// Borra la cuenta encontrada en el objecto `account`
// Transfiere el balance restante a un accountId pasado como argumento.
const near = await connect(config);
const account = await near.account("example-account.testnet");
await account.deleteAccount("beneficiary-account.testnet");''';
const String _snippet09es = '''// Obtener balance de la cuenta
const near = await connect(config);
const account = await near.account("example-account.testnet");
await account.getAccountBalance();''';
const String _snippet10es =
    '''//Obtener detalles de la cuenta en términos de apps autorizadas y transacciones
const near = await connect(config);
const account = await near.account("example-account.testnet");
await account.getAccountDetails();''';
const String _snippet11es = '''// enviar NEAR tokens
const near = await connect(config);
const account = await near.account("sender-account.testnet");
await account.sendMoney(
  "receiver-account.testnet", // cuenta receptora
  "1000000000000000000000000" // cantidad en yoctoNEAR
);''';
const String _snippet12es =
    '''// Crear keyStore usando clave privada almacenada en local storage
//Requiere haber iniciado sesión usando walletConnection.requestSignIn()
const { keyStores } = nearAPI;
const keyStore = new keyStores.BrowserLocalStorageKeyStore();''';
const String _snippet13es = '''// Crear keyStore desde un archivo
//Necesitas pasar la ubicación de el archivo .json
const { keyStores } = nearAPI;
const KEY_PATH = "~./near-credentials/testnet/example-account.json";
const keyStore = new keyStores.UnencryptedFileSystemKeyStore(KEY_PATH);''';
const String _snippet14es = '''// Crear keyStore desde una key String privada
//Puedes poner la key String aquí, o usar una variable de entorno
// creates keyStore from a private key string
// you can define your key here or use an environment variable

const { keyStores, KeyPair } = nearAPI;
const keyStore = new keyStores.InMemoryKeyStore();
const PRIVATE_KEY =
  "by8kdJoJHu7uUkKfoaLd2J2Dp1q1TigeWMG123pHdu9UREqPcshCM223kWadm";
// Este es un ejemplo de clave String privada
const keyPair = KeyPair.fromString(PRIVATE_KEY);
// añade la keyPair creada a la keyStore
await keyStore.setKey("testnet", "example-account.testnet", keyPair);''';
const String _snippet15es = '''// Conectar directo a testnet
const { connect } = nearAPI;

const config = {
  networkId: "testnet",
  keyStore, // optional if not signing transactions
  nodeUrl: "https://rpc.testnet.near.org",
  walletUrl: "https://wallet.testnet.near.org",
  helperUrl: "https://helper.testnet.near.org",
  explorerUrl: "https://explorer.testnet.near.org",
};
const near = await connect(config);''';
const String _snippet16es = '''// Conectar directo a mainnet
const { connect } = nearAPI;

const config = {
  networkId: "mainnet",
  keyStore, // optional if not signing transactions
  nodeUrl: "https://rpc.mainnet.near.org",
  walletUrl: "https://wallet.mainnet.near.org",
  helperUrl: "https://helper.mainnet.near.org",
  explorerUrl: "https://explorer.mainnet.near.org",
};
const near = await connect(config);''';
const String _snippet17es = '''// Conectar directo a betanet
const { connect } = nearAPI;

const config = {
  networkId: "betanet",
  keyStore, // optional if not signing transactions
  nodeUrl: "https://rpc.betanet.near.org",
  walletUrl: "https://wallet.betanet.near.org",
  helperUrl: "https://helper.betanet.near.org",
  explorerUrl: "https://explorer.betanet.near.org",
};
const near = await connect(config);''';
const String _snippet18es = '''// Conectar directo a localnet
const { connect } = nearAPI;
const config = {
  networkId: "local",
  nodeUrl: "http://localhost:3030",
  walletUrl: "http://localhost:4000/wallet",
};
const near = await connect(config);''';
const String _snippet19es = '''//Conectar la Wallet a la app
const { connect, keyStores, WalletConnection } = nearAPI;

// Conexión a NEAR
const near = await connect(config);

// Crear conexión a la wallet
const wallet = new WalletConnection(near);''';
const String _snippet20es = '''#[near_bindgen]
#[derive(BorshDeserialize, BorshSerialize)]
pub struct WhitelistContract {
    /// The account ID of the NEAR Foundation. It allows to whitelist new staking pool accounts.
    /// It also allows to whitelist new Staking Pool Factories, which can whitelist staking pools.
    pub foundation_account_id: AccountId,

    /// The whitelisted account IDs of approved staking pool contracts.
    pub whitelist: LookupSet<AccountId>,

    /// The whitelist of staking pool factories. Any account from this list can whitelist staking
    /// pools.
    pub factory_whitelist: LookupSet<AccountId>,
}''';
const String _snippet21es = '''#[near_bindgen]
impl WhitelistContract {
    /// Initializes the contract with the given NEAR foundation account ID.
    #[init]
    pub fn new(foundation_account_id: AccountId) -> Self {
        assert!(!env::state_exists(), "Already initialized");
        assert!(
            env::is_valid_account_id(foundation_account_id.as_bytes()),
            "The NEAR Foundation account ID is invalid"
        );
        Self {
            foundation_account_id,
            whitelist: LookupSet::new(b"w".to_vec()),
            factory_whitelist: LookupSet::new(b"f".to_vec()),
        }
    }''';
const String _snippet22es =
    '''//Retorna el suministro total de NFT representados como String en u128 para evitar el limite //numerico de JSON de 2^53.
function nft_total_supply(): string {}
// Argumentos:
// * `from_index`: una String representando un int u 128
// * `limit`: el número maximo de tokens a retornar
// Retorna un array de Tokens, y un array vacío si no hay tokens
function nft_tokens(
  from_index: string|null, // default: "0"
  limit: number|null, // default: ilimitado (podría fallar debido al limite de gas)
): Token[] {}''';
const String _snippet23es =
    '''//Obtener el número de tokens poseídos por una cuenta dada
// Argumentos:
// * `account_id`: una cuenta NEAR valida
// Retorna el número de NFT que una cuenta dada posee como una String representando el // valor como u128 para evitar el limite numerico de JSON de 2^53 y un “0” si no hay tokens.
function nft_supply_for_owner(
  account_id: string,
): string {}''';
const String _snippet24es =
    '''// Obtener una lista de todos los tokens poseídos por una cuenta dada
// Argumentos:
// * `account_id`: una cuenta NEAR valida
// * `from_index`: una String representando un int u 128
// * `limit`: el número maximo de tokens a retornar
// Retorna una lista de todos los tokens poseídos por esta cuenta, y un array vacio si no hay // tokens
function nft_tokens_for_owner(
  account_id: string,
  from_index: string|null, // default: 0
  limit: number|null, // default: unlimited (podría fallar debido al limite de gas)
): Token[] {}''';
