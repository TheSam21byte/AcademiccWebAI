import Sidebar from "../components/SideBar";
import Navbar from "../components/Navbar";
import "../styles/dashboard.css";
import { Outlet } from "react-router-dom";

export default function DashboardLayout() {
  return (
    <div className="dashboard-wrapper">
    <Navbar />   {/* Arriba siempre */}
  
      <div className="dash-container">
        <Sidebar />
        <div className="dash-content">
          <div className="dash-inner">
            <Outlet />
          </div>
        </div>
      </div>
    </div>
  );
}
