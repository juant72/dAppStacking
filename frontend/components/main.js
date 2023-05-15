import styles from "../styles/Home.module.css";

import Staking from "./staking.js";
import StakingData from "./stakingdata.js";

export default function Main() {
  return (
    <section className={styles.container}>
      <Staking />
      <StakingData />
    </section>
  );
}