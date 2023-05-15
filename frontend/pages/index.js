import Head from 'next/head'
import styles from '@/styles/Home.module.css'

import Header from "../components/header";
import Main from "../components/main.js";


export default function Home() {
  return( 
    <section className={styles.main}>
      <Head>
        <title>Stakify</title>
      </Head>
      <Header/> 
      <Main/> 
    </section>
  )
}
