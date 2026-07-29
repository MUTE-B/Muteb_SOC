import React from "react";
import { BrowserRouter, Routes, Route, Link } from "react-router-dom";
import Dashboard from "./pages/Dashboard";
import Alerts from "./pages/Alerts";
import Incidents from "./pages/Incidents";
import "./App.css";

function Layout({children}) {
  return (
    <div className="app">
      <aside>
        <h2>MUTEB SOC</h2>
        <nav>
          <Link to="/">Dashboard</Link>
          <Link to="/alerts">Alerts</Link>
          <Link to="/incidents">Incidents</Link>
        </nav>
      </aside>

      <main>
        {children}
      </main>
    </div>
  );
}

function App(){
  return(
    <BrowserRouter>
      <Layout>
        <Routes>
          <Route path="/" element={<Dashboard/>}/>
          <Route path="/alerts" element={<Alerts/>}/>
          <Route path="/incidents" element={<Incidents/>}/>
        </Routes>
      </Layout>
    </BrowserRouter>
  );
}

export default App;
