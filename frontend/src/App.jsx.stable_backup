import React from "react";
import { BrowserRouter, Routes, Route, Link } from "react-router-dom";
import Dashboard from "./pages/Dashboard";
import Alerts from "./pages/Alerts";
import Incidents from "./pages/Incidents";
import "./App.css";

function App() {
  return (
    <BrowserRouter>
      <div className="app">
        <nav>
          <Link to="/">Dashboard</Link> |{" "}
          <Link to="/alerts">Alerts</Link> |{" "}
          <Link to="/incidents">Incidents</Link>
        </nav>

        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/alerts" element={<Alerts />} />
          <Route path="/incidents" element={<Incidents />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;
