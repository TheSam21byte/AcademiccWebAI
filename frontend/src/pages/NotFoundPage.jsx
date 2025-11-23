export default function NotFoundPage() {
  return (
    <div style={{ 
      display: "flex",
      flexDirection: "column",
      justifyContent: "center",
      alignItems: "center",
      height: "100vh",
      background: "#7D1F2E",
      color: "#F5E6D3",
      textAlign: "center"
    }}>
      <h1 style={{ fontSize: "72px", marginBottom: "20px", color: "#C9A961" }}>Error 404</h1>
      <p style={{ fontSize: "24px" }}>Página no encontrada</p>
    </div>
  );
}
