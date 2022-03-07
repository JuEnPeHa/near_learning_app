class Question {
  final int id, answer;
  final String question;
  final List<String> options;
  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
  });
}

List<Question> testUno = [
  Question(
    id: 1,
    question:
        "¿Cual o cuales lenguajes de programación puedes usar para desarrollar en NEAR Protocol?",
    answer: 2,
    options: [
      "RUST",
      "AssemblyScript",
      "Ambos",
      "Ninguno",
    ],
  ),
  Question(
    id: 2,
    question: "¿A qué tipo de bytecode se compilan tus contratos en NEAR?",
    answer: 0,
    options: [
      "WASM",
      "GNU Lightning",
      ".NET Framework",
      "Dalvik",
    ],
  ),
  Question(
    id: 3,
    question: "¿Qué clase de Blockchain es NEAR Protocol?",
    answer: 1,
    options: [
      "Proof of Work:",
      "Proof of Stake",
      "Proof of Authority",
      "Proof of Space & Proof of Time",
    ],
  ),
  Question(
    id: 4,
    question: "Dapplet, Overlay y contract son los componentes principales de ",
    answer: 1,
    options: [
      "Modo de desarrollador",
      "la estructura de la aplicación",
      "De los frameworks",
      "React",
    ],
  ),
  Question(
    id: 5,
    question: "Tiempo entre generación de bloques en NEAR.",
    answer: 2,
    options: [
      "15 segundos.",
      "19 segundos.",
      "1.15 segundos.",
      "4.5 segundos.",
    ],
  ),
  Question(
    id: 6,
    question:
        "Las aplicaciones en NEAR tienen dos partes distintas: un back-end y un front-end. El backend es …",
    answer: 2,
    options: [
      "Mainnet (Red Principal)",
      "Testnet (Red de Pruebas)",
      "Contratos inteligentes",
      "Nodo Validador",
    ],
  ),
  Question(
    id: 7,
    question:
        "Todo el código de contrato se compila en WebAssembly y se implementa en la red para ejecutarse dentro de una _______",
    answer: 1,
    options: [
      "Sandbox (Entorno de pruebas)",
      "Máquina virtual compatible con Wasm",
      "EVM",
      "AVM",
    ],
  ),
  Question(
    id: 8,
    question:
        "Al igual que con cualquier ecosistema basado en blockchain, el protocolo NEAR se ejecuta en una colección de computadoras mantenidas públicamente llamadas _______",
    answer: 0,
    options: [
      "Nodos",
      "Blockchain",
      "Near Protocol",
      "Servidores",
    ],
  ),
  Question(
    id: 9,
    question: "Cada contrato inteligente en NEAR tiene su propio ____ asociado",
    answer: 2,
    options: [
      "Token",
      "Billetera",
      "Cuenta",
      "Todas las anteriores",
    ],
  ),
  Question(
    id: 10,
    question: "Cofundadores de NEAR Protocol:",
    answer: 0,
    options: [
      "Alex Skidanov e Illia Polosukhin",
      "Vitalik Buterin y Robert Habermeier",
      "Bram Cohen y Bill Gates",
      "Silvio Micali y Elon Musk",
    ],
  ),
];

List<Question> testDos = [
  Question(
    id: 1,
    question:
        "¿Cuántas transacciones por segundo puede procesar NEAR Protocol?",
    answer: 3,
    options: [
      "7 tps.",
      "25 tps.",
      "1000 tps.",
      "100,000 tps.",
    ],
  ),
  Question(
    id: 2,
    question:
        "Un simple contrato Near que se crea para un Dapplet puede ubicarse:",
    answer: 0,
    options: [
      "fuera del nodo",
      "fuera del Dapplet",
      "fuera del framework",
      "Modo de desarrollador",
    ],
  ),
  Question(
    id: 3,
    question: "Los Contratos inteligentes son el _____ de su aplicación",
    answer: 1,
    options: [
      "Front-desk",
      "Back-end",
      "Front-end",
      "fuera del framework",
    ],
  ),
  Question(
    id: 4,
    question: "AssemblyScript no es recomendado para:",
    answer: 2,
    options: [
      "Aplicaciones de NFTs",
      "Aplicaciones de Diseño ",
      "Aplicaciones financieras",
      "Front-end",
    ],
  ),
  Question(
    id: 5,
    question: "Meta, Tick-tock, Uber, etc, nacieron en la ",
    answer: 1,
    options: [
      "Web 1.0",
      "Web 2.0",
      "Web 3.0",
      "Ref.finance",
    ],
  ),
  Question(
    id: 6,
    question: "La Web3 tiene los siguientes principios básicos:",
    answer: 0,
    options: [
      "Componibilidad e Inteligencia artificial",
      "Escalabilidad y centralización",
      "Descentralización y seguimiento",
      "Importables en sí mismos",
    ],
  ),
  Question(
    id: 7,
    question: "El siguiente es un caso de uso de la Web3:",
    answer: 2,
    options: [
      "NFTs",
      "Organizaciones Autónomas Descentralizadas",
      "Ambas",
      "Ninguna",
    ],
  ),
  Question(
    id: 8,
    question:
        "Una particularidad de Web3 es que puede conectarse a diferentes sitios web a través de ",
    answer: 1,
    options: [
      "Correo electrónico",
      "Billetera de criptomonedas",
      "Con su cuenta Google",
      "White paper",
    ],
  ),
  Question(
    id: 9,
    question: "En Berry Farm, éstos provienen del Contrato de Berry Club:",
    answer: 0,
    options: [
      " Aguacates y bananas ",
      "Near y Bananas ",
      "Aguacates y Near",
      "La calidad del proceso",
    ],
  ),
  Question(
    id: 10,
    question: "La quema de Tokens, controla:",
    answer: 1,
    options: [
      "Los tokens de las wallets",
      "El suministro circulante",
      "Los tokens en los nodos",
      "Web 2.0",
    ],
  ),
];

List<Question> testTres = [
  Question(
    id: 1,
    question: "La tercera generación de blockchain, resuelve principalmente:",
    answer: 1,
    options: [
      "Delegar tareas",
      "La escalabilidad",
      "Ser un sistema de pago",
      "Diseños",
    ],
  ),
  Question(
    id: 2,
    question: "¿Qué es el Sharding?",
    answer: 0,
    options: [
      "Una técnica de escalabilidad",
      "Un billetera virtual",
      "Un contrato inteligente",
      "Near Development",
    ],
  ),
  Question(
    id: 3,
    question: "¿Cómo se llama el mecanismo de consenso de NEAR?",
    answer: 0,
    options: [
      "Staking",
      "Minting",
      "Nightshade",
      "la presentación",
    ],
  ),
  Question(
    id: 4,
    question: "¿Cuánto dura un TeraGas o TGas?",
    answer: 2,
    options: [
      "1 segundo de tiempo de cómputo",
      "1 microsegundo de tiempo de cómputo",
      "1 milisegundo de tiempo de cómputo",
      "Near Wallet",
    ],
  ),
  Question(
    id: 5,
    question:
        "El contenedor que proporciona seguridad mejorada para el lenguaje de programación Rust para contratos de alto valor es",
    answer: 0,
    options: [
      "Rust - Near-sdk-rs",
      "Rust - Near-skd-rs",
      "Rust - Near-srk-rs",
      "Octopus",
    ],
  ),
  Question(
    id: 6,
    question: "¿Dónde se compila el código de contrato?",
    answer: 2,
    options: [
      "AssemblyScript",
      "TypeScript",
      "WebAssembly",
      "Los nodos",
    ],
  ),
  Question(
    id: 7,
    question:
        "Una de las siguientes es una razón para ejecutar un nodo propio:",
    answer: 1,
    options: [
      "Para unirte a un bloque y buscar transacciones ejecutadas en la blockchain",
      "Para unirte a una red como validador ejecutando un “nodo validador”",
      "Para unirte a un nodo e implementar tu lenguaje de nodos",
      "Swam, IPFS y SIA",
    ],
  ),
  Question(
    id: 8,
    question: "Al ejecutar el código “Guest Book”",
    answer: 2,
    options: [
      "Se ejecuta un nodo de programación en TGas y visitas otros nodos",
      "Se ejecuta el código de la billetera de Near y visitas los usuarios",
      "Para iniciar sesión con Near y agregar un mensaje al libro de visitas",
      "NPunks",
    ],
  ),
  Question(
    id: 9,
    question: "¿Cuál de los siguientes no incluye NFTs?",
    answer: 1,
    options: [
      "Hip Hop Heads - Paras - Mintbase",
      "Overlay - NEARnauts",
      "NearPunks - NEAR Mistfits - NEAR Wallet",
      "Web 3.0",
    ],
  ),
  Question(
    id: 10,
    question: "¿Qué rol roles pueden asumir sus tokens? ",
    answer: 0,
    options: [
      "Pagos dentro y fuera del protocolo",
      "Mapear componentes",
      "Diseño de Testnet",
      "Verano 2019",
    ],
  ),
];
