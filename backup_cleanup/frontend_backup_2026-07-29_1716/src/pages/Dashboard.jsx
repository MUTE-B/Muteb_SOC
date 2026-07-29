import React, { useEffect, useState } from "react";
import api from "../services/api";

function Dashboard() {

  const [data, setData] = useState({
    critical_alerts: 0,
    open_incidents: 0,
    threat_score: 0
  });

  useEffect(() => {

    api.get("/api/dashboard")
      .then(res => {
        setData(res.data);
      })
      .catch(() => {

        setData({
          critical_alerts: 0,
          open_incidents: 1,
          threat_score: 80
        });

      });

  }, []);


  return (
    <div>
      <h1>SOC Overview</h1>

      <h2>Critical Alerts</h2>
      <p>{data.critical_alerts}</p>

      <h2>Open Incidents</h2>
      <p>{data.open_incidents}</p>

      <h2>Threat Score</h2>
      <p>{data.threat_score}</p>

    </div>
  );
}

export default Dashboard;
