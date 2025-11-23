import { BrowserRouter, Routes, Route } from "react-router-dom";
import LoginPage from "../pages/LoginPage";
import NotFoundPage from "../pages/NotFoundPage"; 
import DashboardPage from "../pages/DashboardPage";
import DashboardLayout from "../layout/DashboardLayout";
import CursosPage from "../pages/CursosPage";
import RendimientoPage from "../pages/RendimientoPage";
import ChatPage from "../pages/ChatPage";
import ConfiguracionPage from "../pages/ConfiguracionPage";

export default function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>

        {/* Página de Login */}
        <Route path="/" element={<LoginPage />} />

        {/* TODAS las rutas del dashboard usan layout */}
        <Route path="/dashboard" element={<DashboardLayout />}>
          
          {/* Página principal */}
          <Route index element={<DashboardPage />} />

          {/* Subpáginas */}
          <Route path="cursos" element={<CursosPage />} />
          <Route path="rendimiento" element={<RendimientoPage />} />
          <Route path="chat" element={<ChatPage />} />
          <Route path="configuracion" element={<ConfiguracionPage />} />

        </Route>

        {/* 404 */}
        <Route path="*" element={<NotFoundPage />} />
      </Routes>
    </BrowserRouter>
  );
}
