import { useEffect, useS } from "react";
import {Beans} from "@web3uikit/icons";
import style from "../styles.Home.module.css";
import {useAccount, userConnect, userDisconnect} from "wagmi";

export default function Header(){
    const [isLoggedIn, setIsLoggedIn] = useState(false);
    const {isConnect}= useAccount();
    const {connect, connectors}= useConnect();
    const {disconnect}= useDisconnect();
    


}