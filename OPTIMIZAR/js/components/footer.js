let logoURL = "https://gms.gumtree.co.za/v2/images/za_ads_133423581_250901_68b59f9b58d269000a3d2284?size=l";

let socialNetworks = [
  {
    name: "Facebook",
    icon: "fab fa-facebook-f",
    color: "#2563EB",
    url: "#",
  },
  {
    name: "Twitter",
    icon: "fab fa-twitter",
    color: "#1DA1F2",
    url: "#",
  },
  {
    name: "Instagram",
    icon: "fab fa-instagram",
    color: "#E4405F",
    url: "#",
  },
  {
    name: "LinkedIn",
    icon: "fab fa-linkedin-in",
    color: "#0A66C2",
    url: "#",
  },
]

let socialNetworksHTML = ""
socialNetworks.forEach(network => {
  socialNetworksHTML += `
    <a
      href="${network.url}"
      class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center hover:bg-[${network.color}] transition-colors"
    >
      <i class="${network.icon}"></i>
    </a>
  `
})

let legalLinks = [
  { name: "Términos y Condiciones", url: "#" },
  { name: "Política de Privacidad", url: "#" },
  { name: "Cookies", url: "#" },
  { name: "Aviso Legal", url: "#" },
  { name: "Protección de Datos", url: "#" },
]

let legalLinksHTML = ""
legalLinks.forEach(link => {
  legalLinksHTML += `
    <li>
      <a
        href="${link.url}"
        class="text-gray-400 hover:text-white transition-colors"
      >${link.name}</a>
    </li>
  `
})

let otherLinks = [
  { name: "Mapa del sitio", url: "#" },
  { name: "Ayuda", url: "#" },
  { name: "Preguntas frecuentes", url: "#" },
]

let otherLinksHTML = ""
otherLinks.forEach(link => {
  otherLinksHTML += `
    <a
      href="${link.url}"
      class="text-gray-400 hover:text-white text-sm transition-colors"
    >${link.name}</a>
  `
})

let currentYear = new Date().getFullYear()

let footer = `
  <div class="container mx-auto px-4">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
      <!-- Columna 1: Logo y descripción -->
      <div>
        <div class="flex items-center space-x-3 mb-4">
          <img src="${logoURL}" alt="ComparaSalud" class="w-10 h-10 rounded-full object-cover" />
          <span class="text-xl font-bold">ComparaSalud</span>
        </div>
        <p class="text-gray-400 mb-4">
          Democratizando el acceso a servicios de salud transparentes y
          accesibles para todos.
        </p>
        <!-- Redes Sociales -->
        <div class="flex space-x-4">
          ${socialNetworksHTML}
        </div>
      </div>

      <!-- Columna 2: Enlaces legales -->
      <div>
        <h3 class="font-bold text-lg mb-4">Legal</h3>
        <ul class="space-y-2">
          ${legalLinksHTML}
        </ul>
      </div>

      <!-- Columna 3: Información de contacto -->
      <div>
        <h3 class="font-bold text-lg mb-4">Contacto</h3>
        <ul class="space-y-3">
          <li class="flex items-center text-gray-400">
            <i class="fas fa-map-marker-alt mr-3"></i>
            <span>Av. Javier Prado 1234, Lima</span>
          </li>
          <li class="flex items-center text-gray-400">
            <i class="fas fa-phone mr-3"></i>
            <span>(+51) 987654321</span>
          </li>
          <li class="flex items-center text-gray-400">
            <i class="far fa-envelope mr-3"></i>
            <span>help@comparasalud.com</span>
          </li>
          <li class="flex items-center text-gray-400">
            <i class="far fa-clock mr-3"></i>
            <span>Lun-Sab: 8:00 - 18:00</span>
          </li>
        </ul>
      </div>

      <!-- Columna 4: Descarga app móvil -->
      <div>
        <h3 class="font-bold text-lg mb-4">Descarga nuestra app</h3>
        <p class="text-gray-400 mb-4">
          Disponible en iOS y Android. Compara y agenda desde tu móvil.
        </p>
        <div class="flex flex-col space-y-3">
          <a
            href="https://www.apple.com/la/app-store/"
            class="bg-black text-white px-4 py-3 rounded-lg flex items-center justify-center hover:bg-gray-900 transition-colors"
          >
            <i class="fab fa-apple text-2xl mr-3"></i>
            <div class="text-left">
              <div class="text-xs">Descargar en</div>
              <div class="font-semibold">App Store</div>
            </div>
          </a>
          <a
            href="https://play.google.com/store/"
            class="bg-black text-white px-4 py-3 rounded-lg flex items-center justify-center hover:bg-gray-900 transition-colors"
          >
            <i class="fab fa-google-play text-xl mr-3"></i>
            <div class="text-left">
              <div class="text-xs">Disponible en</div>
              <div class="font-semibold">Google Play</div>
            </div>
          </a>
        </div>
      </div>
    </div>

    <!-- Línea divisoria -->
    <div class="border-t border-gray-700 pt-8">
      <div class="flex flex-col md:flex-row justify-between items-center">
        <p class="text-gray-400 text-sm mb-4 md:mb-0">
          © ${currentYear} ComparaSalud. Todos los derechos reservados.
        </p>
        <div class="flex space-x-6">
          ${otherLinksHTML}
        </div>
      </div>
    </div>
  </div>
`;

document.getElementById("footer").innerHTML = footer;