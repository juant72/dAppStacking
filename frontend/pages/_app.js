import '@/styles/globals.css'
import {
  configureChains,
  sepolia,
  WagmiConfig,
  createClient
  } from "wagmi";

  import { publicProvider} from "wagmi/providers/public";


export default function App({ Component, pageProps }) {
  const {provider, webSocketProvider} = configureChains(
    [sepolia],
    [publicProvider()],
  );
  
  return <Component {...pageProps} />
}
