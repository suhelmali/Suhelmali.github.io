<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FuelReceiptPro — Digital Fuel Receipt Prototype</title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; min-height: 100vh; }
.navbar { background: #1a1a2e; color: white; padding: 16px 0; }
.container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
.navbar-brand { font-size: 1.5rem; font-weight: 800; text-decoration: none; color: white; }
.navbar-brand span { color: #FFD700; }
.nav-links { display: flex; gap: 24px; align-items: center; }
.nav-links a { color: rgba(255,255,255,0.8); text-decoration: none; font-size: 0.95rem; transition: color 0.2s; }
.nav-links a:hover { color: white; }
.hero { background: linear-gradient(135deg, #006341 0%, #00A86B 100%); color: white; padding: 80px 0; text-align: center; border-radius: 0 0 40px 40px; margin-bottom: 40px; }
.hero h1 { font-size: 3rem; margin-bottom: 16px; }
.hero p { font-size: 1.2rem; opacity: 0.85; margin-bottom: 32px; }
.btn { display: inline-block; padding: 14px 32px; border-radius: 10px; text-decoration: none; font-weight: 600; font-size: 1rem; border: none; cursor: pointer; transition: all 0.2s; }
.btn-light { background: white; color: #006341; }
.btn-light:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.15); }
.btn-outline { background: transparent; color: white; border: 2px solid rgba(255,255,255,0.5); }
.btn-outline:hover { background: rgba(255,255,255,0.1); }
.btn-primary { background: #006341; color: white; }
.btn-primary:hover { background: #00A86B; }
.btn-success { background: #00A86B; color: white; }
.btn-success:hover { background: #008f5a; }
.btn-outline-primary { background: transparent; color: #006341; border: 2px solid #006341; }
.btn-outline-primary:hover { background: #006341; color: white; }
.btn-sm { padding: 8px 16px; font-size: 0.85rem; }
.btn-lg { padding: 16px 36px; font-size: 1.1rem; }
.d-flex { display: flex; }
.justify-content-between { justify-content: space-between; }
.align-items-center { align-items: center; }
.gap-2 { gap: 12px; }
.gap-3 { gap: 16px; }
.mt-3 { margin-top: 16px; }
.mt-4 { margin-top: 24px; }
.mb-3 { margin-bottom: 16px; }
.mb-4 { margin-bottom: 24px; }
.text-center { text-align: center; }
.text-muted { color: #6c757d; }
.text-success { color: #00A86B; }
.text-primary { color: #006341; }
.text-warning { color: #FF9800; }
.fw-bold { font-weight: 700; }
.fs-4 { font-size: 1.5rem; }
.fs-5 { font-size: 1.25rem; }
.small { font-size: 0.875rem; }
.row { display: flex; flex-wrap: wrap; margin: 0 -12px; }
.col-md-3, .col-md-4, .col-md-6, .col-md-8, .col-lg-6 { padding: 0 12px; }
.col-md-3 { width: 25%; }
.col-md-4 { width: 33.333%; }
.col-md-6 { width: 50%; }
.col-md-8 { width: 66.667%; }
.col-lg-6 { width: 50%; }
.card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 24px; margin-bottom: 24px; }
.card-header { padding-bottom: 16px; margin-bottom: 16px; border-bottom: 1px solid #eee; }
.stat-card { text-align: center; padding: 24px; }
.stat-icon { width: 60px; height: 60px; border-radius: 14px; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; font-size: 1.5rem; color: white; }
.stat-value { font-size: 2rem; font-weight: 800; color: #1a1a2e; }
.stat-label { color: #6c757d; font-size: 0.9rem; margin-top: 4px; }
.table { width: 100%; border-collapse: collapse; }
.table th, .table td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
.table th { background: #f8f9fa; font-weight: 600; }
.table tbody tr:hover { background: #f0f7f4; }
.badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
.badge-primary { background: #006341; color: white; }
.badge-success { background: #00A86B; color: white; }
.badge-dark { background: #1a1a2e; color: white; }
.badge-secondary { background: #6c757d; color: white; }
.badge-vat { background: #e8f5e9; color: #2e7d32; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
.pos-screen { background: #1a1a2e; border-radius: 20px; padding: 30px; color: white; max-width: 500px; margin: 0 auto; }
.pos-display { background: #0f3460; border-radius: 12px; padding: 20px; margin-bottom: 20px; font-family: 'Courier New', monospace; font-size: 1.1rem; }
.form-control, .form-select { width: 100%; padding: 12px 16px; border-radius: 10px; border: 1px solid #444; background: #2d3436; color: white; font-size: 1rem; }
.form-control:focus, .form-select:focus { outline: none; border-color: #00A86B; }
.form-label { display: block; margin-bottom: 8px; color: rgba(255,255,255,0.7); font-size: 0.9rem; }
.input-group { display: flex; }
.input-group-text { padding: 12px 16px; background: #2d3436; border: 1px solid #444; border-right: none; border-radius: 10px 0 0 10px; color: white; }
.input-group .form-control { border-radius: 0 10px 10px 0; }
.receipt-paper { background: white; border: 1px dashed #ccc; padding: 40px; max-width: 400px; margin: 0 auto; position: relative; }
.receipt-paper::before, .receipt-paper::after { content: ''; position: absolute; left: 0; right: 0; height: 10px; background: radial-gradient(circle, transparent 6px, white 6px); background-size: 20px 20px; }
.receipt-paper::before { top: -5px; }
.receipt-paper::after { bottom: -5px; transform: rotate(180deg); }
.vehicle-card { border-left: 4px solid #006341; padding-left: 16px; }
.email-preview { background: #f8f9fa; border: 1px solid #dee2e6; border-radius: 8px; padding: 20px; }
.email-header { border-bottom: 1px solid #dee2e6; padding-bottom: 12px; margin-bottom: 16px; }
.alert { padding: 16px 20px; border-radius: 10px; margin-bottom: 16px; }
.alert-success { background: #e8f5e9; color: #2e7d32; border: 1px solid #4caf50; }
.alert-error { background: #ffebee; color: #c62828; border: 1px solid #ef5350; }
.page { display: none; }
.page.active { display: block; }
footer { background: #1a1a2e; color: rgba(255,255,255,0.6); padding: 24px 0; text-align: center; margin-top: 40px; }
footer p { margin-bottom: 4px; }
footer small { opacity: 0.5; }
.py-4 { padding: 32px 0; }
.p-3 { padding: 16px; }
.p-4 { padding: 24px; }
.bg-light { background: #f8f9fa; }
.rounded { border-radius: 10px; }
.border-top { border-top: 1px solid #eee; }
hr { border: none; border-top: 1px solid #eee; margin: 16px 0; }
hr.border-light { border-color: rgba(255,255,255,0.2); }
.d-grid { display: grid; }
.d-inline-block { display: inline-block; }
.w-100 { width: 100%; }
@media (max-width: 768px) {
  .col-md-3, .col-md-4, .col-md-6, .col-md-8, .col-lg-6 { width: 100%; }
  .row { flex-direction: column; }
  .hero h1 { font-size: 2rem; }
  .nav-links { display: none; }
}
</style>
<base target="_blank">
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
  <div class="container d-flex justify-content-between align-items-center">
    <a href="#" class="navbar-brand" onclick="showPage('home')">
      <span style="color:#FFD700;">⛽</span> FuelReceipt<span style="color:#FFD700;">Pro</span>
    </a>
    <div class="nav-links">
      <a href="#" onclick="showPage('pos')">🖥️ Fuel Station POS</a>
      <a href="#" onclick="showPage('dashboard')">📊 Company Dashboard</a>
      <a href="#" onclick="showPage('admin')">⚙️ Admin</a>
    </div>
  </div>
</nav>

<!-- FLASH MESSAGES -->
<div id="flashMessages" style="position:fixed;top:80px;right:20px;z-index:1050;min-width:300px;"></div>

<!-- ==================== HOME PAGE ==================== -->
<div id="home" class="page active">
  <div class="hero">
    <div class="container">
      <h1>No More Lost Fuel Receipts</h1>
      <p>Automated digital receipts with instant VAT reporting for corporate fleets in the UAE</p>
      <div class="d-flex justify-content-center gap-3" style="flex-wrap:wrap;">
        <a href="#" class="btn btn-light btn-lg" onclick="showPage('pos')">🖥️ Try POS Demo</a>
        <a href="#" class="btn btn-outline btn-lg" onclick="showPage('dashboard')">📊 View Dashboard</a>
      </div>
    </div>
  </div>

  <div class="container mb-5">
    <div class="row">
      <div class="col-md-4">
        <div class="card text-center">
          <div style="width:80px;height:80px;background:white;border-radius:20px;display:flex;align-items:center;justify-content:center;font-size:2rem;color:#006341;margin:0 auto 20px;box-shadow:0 4px 15px rgba(0,0,0,0.1);">🚗</div>
          <h4 class="fw-bold">Vehicle Registration</h4>
          <p class="text-muted">Register fleet vehicles with plate numbers. Link each vehicle to a company with VAT TRN for automatic receipt routing.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card text-center">
          <div style="width:80px;height:80px;background:white;border-radius:20px;display:flex;align-items:center;justify-content:center;font-size:2rem;color:#006341;margin:0 auto 20px;box-shadow:0 4px 15px rgba(0,0,0,0.1);">🧾</div>
          <h4 class="fw-bold">Instant Digital Receipts</h4>
          <p class="text-muted">When fuel is purchased, the receipt is automatically sent to the company's dashboard and email — no paper needed.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card text-center">
          <div style="width:80px;height:80px;background:white;border-radius:20px;display:flex;align-items:center;justify-content:center;font-size:2rem;color:#006341;margin:0 auto 20px;box-shadow:0 4px 15px rgba(0,0,0,0.1);">💰</div>
          <h4 class="fw-bold">VAT-Ready Reports</h4>
          <p class="text-muted">Generate monthly VAT reports with all fuel transactions, VAT amounts, and invoice details — ready for FTA submission.</p>
        </div>
      </div>
    </div>
  </div>

  <div class="container mb-5">
    <div class="card" style="background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); color: white;">
      <div class="row" style="padding: 40px;">
        <div class="col-md-6">
          <h2 class="fw-bold mb-3">How It Works</h2>
          <div class="d-flex mb-3" style="gap:16px;">
            <span class="badge badge-primary" style="min-width:30px;height:30px;display:flex;align-items:center;justify-content:center;">1</span>
            <div><h5 style="margin-bottom:4px;">Company registers fleet vehicles</h5><p style="opacity:0.75;margin:0;">Add vehicles with plate numbers, fuel type, and driver details</p></div>
          </div>
          <div class="d-flex mb-3" style="gap:16px;">
            <span class="badge badge-primary" style="min-width:30px;height:30px;display:flex;align-items:center;justify-content:center;">2</span>
            <div><h5 style="margin-bottom:4px;">Driver fuels at ADNOC station</h5><p style="opacity:0.75;margin:0;">Cashier enters plate number at POS — vehicle auto-detected</p></div>
          </div>
          <div class="d-flex mb-3" style="gap:16px;">
            <span class="badge badge-primary" style="min-width:30px;height:30px;display:flex;align-items:center;justify-content:center;">3</span>
            <div><h5 style="margin-bottom:4px;">Receipt auto-delivered digitally</h5><p style="opacity:0.75;margin:0;">Goes to company dashboard + email instantly with VAT breakdown</p></div>
          </div>
          <div class="d-flex" style="gap:16px;">
            <span class="badge badge-primary" style="min-width:30px;height:30px;display:flex;align-items:center;justify-content:center;">4</span>
            <div><h5 style="margin-bottom:4px;">Monthly VAT report generated</h5><p style="opacity:0.75;margin:0;">One-click export for FTA compliance and accounting</p></div>
          </div>
        </div>
        <div class="col-md-6 text-center">
          <div class="receipt-paper" style="transform:rotate(-2deg);box-shadow:0 10px 30px rgba(0,0,0,0.3);">
            <div style="text-align:center;margin-bottom:12px;">
              <div style="font-size:2rem;color:#00A86B;">⛽</div>
              <h5 style="font-weight:bold;margin:8px 0 0;">ADNOC</h5>
              <small style="color:#6c757d;">Sheikh Zayed Road Station</small>
            </div>
            <hr>
            <div class="d-flex justify-content-between small"><span>Date:</span><span>01-Jul-2026</span></div>
            <div class="d-flex justify-content-between small"><span>Time:</span><span>08:30 AM</span></div>
            <div class="d-flex justify-content-between small"><span>Vehicle:</span><span><strong>A12345</strong></span></div>
            <hr>
            <div class="d-flex justify-content-between"><span>Special 95</span><span>45.5 L</span></div>
            <div class="d-flex justify-content-between"><span style="color:#6c757d;">@ AED 2.92/L</span><span>AED 132.86</span></div>
            <hr>
            <div class="d-flex justify-content-between fw-bold"><span>VAT (5%)</span><span>AED 6.64</span></div>
            <div class="d-flex justify-content-between fw-bold fs-5" style="color:#00A86B;"><span>TOTAL</span><span>AED 139.50</span></div>
            <hr>
            <div style="text-align:center;"><small style="color:#6c757d;">Sent to: accounts@dubailogistics.ae</small></div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="container mb-5">
    <h2 class="text-center fw-bold mb-4">Demo Access</h2>
    <div class="row">
      <div class="col-md-6">
        <div class="card">
          <div class="d-flex align-items-center mb-3">
            <div style="width:50px;height:50px;background:#006341;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:white;">🖥️</div>
            <h4 class="fw-bold ms-3 mb-0">Fuel Station POS</h4>
          </div>
          <p class="text-muted">Cashier interface for processing fuel transactions. Enter plate number, fuel details, and payment — receipt auto-sends to company.</p>
          <a href="#" class="btn btn-primary" onclick="showPage('pos')">Open POS →</a>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card">
          <div class="d-flex align-items-center mb-3">
            <div style="width:50px;height:50px;background:#00A86B;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:white;">🏢</div>
            <h4 class="fw-bold ms-3 mb-0">Company Dashboard</h4>
          </div>
          <p class="text-muted">Fleet manager view with all transactions, VAT reports, vehicle tracking, and export capabilities.</p>
          <a href="#" class="btn btn-success" onclick="showPage('dashboard')">Open Dashboard →</a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- ==================== POS DASHBOARD ==================== -->
<div id="pos" class="page">
  <div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h2 class="fw-bold mb-0">🖥️ ADNOC Station POS</h2>
        <p class="text-muted mb-0">Sheikh Zayed Road — Terminal #01</p>
      </div>
      <a href="#" class="btn btn-primary btn-lg" onclick="showPage('pos_new')">➕ New Transaction</a>
    </div>

    <div class="row mb-4">
      <div class="col-md-3"><div class="card stat-card"><div class="stat-icon" style="background:linear-gradient(135deg,#006341,#00A86B);">🧾</div><div class="stat-value" id="posStatCount">3</div><div class="stat-label">Today's Transactions</div></div></div>
      <div class="col-md-3"><div class="card stat-card"><div class="stat-icon" style="background:linear-gradient(135deg,#2196F3,#03A9F4);">⛽</div><div class="stat-value" id="posStatLiters">149</div><div class="stat-label">Total Fuel Dispensed</div></div></div>
      <div class="col-md-3"><div class="card stat-card"><div class="stat-icon" style="background:linear-gradient(135deg,#FF9800,#FFC107);">💵</div><div class="stat-value" id="posStatRevenue">449</div><div class="stat-label">Total Revenue</div></div></div>
      <div class="col-md-3"><div class="card stat-card"><div class="stat-icon" style="background:linear-gradient(135deg,#9C27B0,#E91E63);">📤</div><div class="stat-value" id="posStatSent">3</div><div class="stat-label">Receipts Sent</div></div></div>
    </div>

    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="fw-bold mb-0">📋 Recent Transactions</h5>
        <span class="badge badge-primary">Live</span>
      </div>
      <div style="overflow-x:auto;">
        <table class="table" id="posTxnTable">
          <thead><tr><th>ID</th><th>Time</th><th>Vehicle</th><th>Fuel Type</th><th>Liters</th><th>Amount</th><th>VAT</th><th>Total</th><th>Payment</th><th>Status</th><th>Action</th></tr></thead>
          <tbody id="posTxnBody"></tbody>
        </table>
      </div>
    </div>

    <div class="card mt-4">
      <div class="card-header"><h5 class="fw-bold mb-0">🚗 Registered Vehicles</h5></div>
      <div class="card-body">
        <div class="row" id="posVehicleGrid"></div>
      </div>
    </div>
  </div>
</div>

<!-- ==================== POS NEW TRANSACTION ==================== -->
<div id="pos_new" class="page">
  <div class="container py-4">
    <div class="row justify-content-center">
      <div class="col-lg-6">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2 class="fw-bold mb-0">➕ New Fuel Transaction</h2>
          <a href="#" class="btn btn-outline-secondary" onclick="showPage('pos')">← Back to POS</a>
        </div>

        <div class="pos-screen">
          <div class="text-center mb-4">
            <div style="font-size:2rem;color:#FFD700;margin-bottom:8px;">⛽</div>
            <h4 class="fw-bold mb-0">ADNOC</h4>
            <small style="opacity:0.75;">Sheikh Zayed Road Station</small>
          </div>

          <form id="fuelForm" onsubmit="return submitTransaction(event)">
            <div class="pos-display mb-4">
              <div class="d-flex justify-content-between mb-2"><span>Plate Number:</span><span id="dispPlate" class="fw-bold" style="color:#FFD700;">---</span></div>
              <div class="d-flex justify-content-between mb-2"><span>Vehicle:</span><span id="dispVehicle" class="fw-bold">---</span></div>
              <div class="d-flex justify-content-between mb-2"><span>Company:</span><span id="dispCompany" class="fw-bold" style="color:#00A86B;">---</span></div>
              <div class="d-flex justify-content-between mb-2"><span>Fuel Type:</span><span id="dispFuelType" class="fw-bold">---</span></div>
              <div class="d-flex justify-content-between mb-2"><span>Liters:</span><span id="dispLiters" class="fw-bold" style="color:#FFD700;">0.00 L</span></div>
              <hr class="border-light">
              <div class="d-flex justify-content-between"><span>Subtotal:</span><span id="dispAmount" class="fw-bold">AED 0.00</span></div>
              <div class="d-flex justify-content-between"><span>VAT (5%):</span><span id="dispVAT" class="fw-bold" style="color:#FFD700;">AED 0.00</span></div>
              <div class="d-flex justify-content-between fs-4 mt-2"><span class="fw-bold">TOTAL:</span><span id="dispTotal" class="fw-bold" style="color:#FFD700;">AED 0.00</span></div>
            </div>

            <div class="mb-3">
              <label class="form-label">Vehicle Plate Number</label>
              <div class="input-group">
                <span class="input-group-text">UAE</span>
                <input type="text" class="form-control" id="plateInput" placeholder="e.g. A12345" onkeyup="lookupVehicle()">
              </div>
              <div id="vehicleInfo" style="margin-top:8px;font-size:0.85rem;"></div>
            </div>

            <div class="mb-3">
              <label class="form-label">Fuel Type</label>
              <select class="form-select" id="fuelType" onchange="calculateTotal()">
                <option value="">Select Fuel Type</option>
                <option value="Special 95" data-price="2.92">Special 95 — AED 2.92/L</option>
                <option value="Super 98" data-price="3.05">Super 98 — AED 3.05/L</option>
                <option value="E-Plus 91" data-price="2.80">E-Plus 91 — AED 2.80/L</option>
                <option value="Diesel" data-price="2.75">Diesel — AED 2.75/L</option>
              </select>
            </div>

            <div class="mb-3">
              <label class="form-label">Liters</label>
              <input type="number" step="0.01" class="form-control" id="litersInput" placeholder="0.00" oninput="calculateTotal()">
            </div>

            <div class="mb-3">
              <label class="form-label">Payment Method</label>
              <select class="form-select" id="paymentMethod">
                <option value="Card">Credit/Debit Card</option>
                <option value="Cash">Cash</option>
                <option value="Fleet Card">Fleet Card</option>
              </select>
            </div>

            <div class="d-grid" style="gap:12px;">
              <button type="submit" class="btn btn-success btn-lg" id="submitBtn" disabled>✅ Complete Transaction & Send Receipt</button>
              <a href="#" class="btn btn-outline" onclick="showPage('pos')">❌ Cancel</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- ==================== RECEIPT VIEW ==================== -->
<div id="receipt" class="page">
  <div class="container py-4">
    <div class="row">
      <div class="col-lg-6">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2 class="fw-bold mb-0">🧾 Transaction Receipt</h2>
          <a href="#" class="btn btn-outline-secondary" onclick="showPage('pos')">← Back to POS</a>
        </div>
        <div id="receiptContent"></div>
        <div class="text-center mt-3">
          <button class="btn btn-primary me-2" onclick="window.print()">🖨️ Print Receipt</button>
          <a href="#" class="btn btn-success" onclick="showPage('pos_new')">➕ New Transaction</a>
        </div>
      </div>
      <div class="col-lg-6">
        <h4 class="fw-bold mb-3">📧 Email Receipt Preview</h4>
        <p class="text-muted">This is what the company receives instantly after the transaction:</p>
        <div id="emailPreview"></div>
        <div class="card mt-4" style="background:#e8f5e9;border:1px solid #4caf50;">
          <div class="card-body">
            <h5 class="fw-bold text-success mb-2">✅ Receipt Delivered</h5>
            <p class="mb-0">This receipt has been automatically sent to:</p>
            <ul style="margin-top:8px;padding-left:20px;">
              <li>📧 <span id="receiptEmail"></span></li>
              <li>📊 Company Dashboard</li>
              <li>📄 VAT Report System</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- ==================== COMPANY DASHBOARD ==================== -->
<div id="dashboard" class="page">
  <div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h2 class="fw-bold mb-0">🏢 <span id="dashCompanyName">Dubai Logistics LLC</span></h2>
        <p class="text-muted mb-0">
          <span class="badge badge-dark me-2">VAT: <span id="dashVAT">100123456700003</span></span>
          <span class="badge badge-secondary" id="dashEmail">accounts@dubailogistics.ae</span>
        </p>
      </div>
      <div class="d-flex gap-2">
        <a href="#" class="btn btn-success" onclick="showPage('vat_report')">📄 VAT Report</a>
        <a href="#" class="btn btn-outline-primary" onclick="exportCSV()">⬇️ Export CSV</a>
      </div>
    </div>

    <div class="row mb-4">
      <div class="col-md-3"><div class="card stat-card"><div class="stat-icon" style="background:linear-gradient(135deg,#006341,#00A86B);">🚗</div><div class="stat-value" id="dashVehicles">3</div><div class="stat-label">Fleet Vehicles</div></div></div>
      <div class="col-md-3"><div class="card stat-card"><div class="stat-icon" style="background:linear-gradient(135deg,#2196F3,#03A9F4);">🧾</div><div class="stat-value" id="dashTxns">3</div><div class="stat-label">Total Transactions</div></div></div>
      <div class="col-md-3"><div class="card stat-card"><div class="stat-icon" style="background:linear-gradient(135deg,#FF9800,#FFC107);">⛽</div><div class="stat-value" id="dashLiters">149</div><div class="stat-label">Total Fuel</div></div></div>
      <div class="col-md-3"><div class="card stat-card"><div class="stat-icon" style="background:linear-gradient(135deg,#9C27B0,#E91E63);">💵</div><div class="stat-value" id="dashSpent">449</div><div class="stat-label">Total Spent</div></div></div>
    </div>

    <div class="row mb-4">
      <div class="col-md-8">
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0">📋 Transaction History</h5>
            <span class="badge badge-success" id="dashTxnCount">3 records</span>
          </div>
          <div style="overflow-x:auto;">
            <table class="table" id="dashTxnTable">
              <thead><tr><th>Date</th><th>Vehicle</th><th>Station</th><th>Fuel</th><th>Liters</th><th>Amount</th><th>VAT</th><th>Total</th></tr></thead>
              <tbody id="dashTxnBody"></tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card">
          <div class="card-header"><h5 class="fw-bold mb-0">🚗 Registered Vehicles</h5></div>
          <div class="card-body" id="dashVehicleList"></div>
        </div>
      </div>
    </div>

    <div class="card">
      <div class="card-header"><h5 class="fw-bold mb-0">📊 VAT Summary</h5></div>
      <div class="card-body">
        <div class="row">
          <div class="col-md-4 text-center"><div class="p-4 rounded" style="background:#e3f2fd;"><h3 class="fw-bold text-primary mb-1" id="dashExclVAT">427</h3><p class="text-muted mb-0">Total Fuel Cost (Excl. VAT)</p></div></div>
          <div class="col-md-4 text-center"><div class="p-4 rounded" style="background:#e8f5e9;"><h3 class="fw-bold text-success mb-1" id="dashVATTotal">21</h3><p class="text-muted mb-0">Total VAT (5%) — Claimable</p></div></div>
          <div class="col-md-4 text-center"><div class="p-4 rounded" style="background:#fff3e0;"><h3 class="fw-bold text-warning mb-1" id="dashInclVAT">449</h3><p class="text-muted mb-0">Total Amount (Incl. VAT)</p></div></div>
        </div>
        <div class="text-center mt-4">
          <a href="#" class="btn btn-success btn-lg" onclick="showPage('vat_report')">📄 Generate Monthly VAT Report</a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- ==================== VAT REPORT ==================== -->
<div id="vat_report" class="page">
  <div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h2 class="fw-bold mb-0">📄 VAT Report</h2>
        <p class="text-muted mb-0"><span id="vatCompanyName">Dubai Logistics LLC</span> — <span id="vatMonth">2026-06</span></p>
      </div>
      <div class="d-flex gap-2">
        <a href="#" class="btn btn-outline-secondary" onclick="showPage('dashboard')">← Back to Dashboard</a>
        <button class="btn btn-primary" onclick="window.print()">🖨️ Print Report</button>
      </div>
    </div>

    <div class="card mb-4" style="border:2px solid #006341;">
      <div class="card-body">
        <div class="row align-items-center">
          <div class="col-md-6">
            <h4 class="fw-bold mb-2">Tax Invoice Summary</h4>
            <p class="mb-1"><strong>Company:</strong> <span id="vatCompName">Dubai Logistics LLC</span></p>
            <p class="mb-1"><strong>VAT TRN:</strong> <span id="vatTRN">100123456700003</span></p>
            <p class="mb-1"><strong>Period:</strong> <span id="vatPeriod">2026-06</span></p>
            <p class="mb-0"><strong>Report Date:</strong> 2026-07-01</p>
          </div>
          <div class="col-md-6 text-md-end">
            <div class="d-inline-block text-start p-4 rounded" style="background:#f8f9fa;">
              <div class="d-flex justify-content-between mb-2"><span>Total Transactions:</span><span class="fw-bold" id="vatTxnCount">3</span></div>
              <div class="d-flex justify-content-between mb-2"><span>Taxable Amount:</span><span class="fw-bold" id="vatTaxable">AED 427.51</span></div>
              <div class="d-flex justify-content-between mb-2"><span>VAT Amount (5%):</span><span class="fw-bold text-success" id="vatAmount">AED 21.38</span></div>
              <hr>
              <div class="d-flex justify-content-between fs-5"><span class="fw-bold">Grand Total:</span><span class="fw-bold text-primary" id="vatGrand">AED 448.89</span></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="card">
      <div class="card-header"><h5 class="fw-bold mb-0">📋 Detailed Transaction List</h5></div>
      <div style="overflow-x:auto;">
        <table class="table" id="vatTable">
          <thead><tr><th>#</th><th>Invoice Date</th><th>Supplier</th><th>Description</th><th>Vehicle</th><th>Qty (L)</th><th>Unit Price</th><th>Taxable Amount</th><th>VAT (5%)</th><th>Total</th><th>TRN</th></tr></thead>
          <tbody id="vatBody"></tbody>
        </table>
      </div>
    </div>

    <div class="card mt-4" style="background:#e8f5e9;">
      <div class="card-body">
        <h5 class="fw-bold text-success mb-3">🛡️ FTA Compliance Statement</h5>
        <p class="mb-2">This report is generated in compliance with UAE Federal Tax Authority requirements:</p>
        <ul style="margin-bottom:0;">
          <li>All transactions include valid Tax Registration Number (TRN)</li>
          <li>VAT is calculated at the standard rate of 5% as per UAE VAT Law</li>
          <li>Original digital receipts are retained for the mandatory 5-year period</li>
          <li>All fuel purchases are for business use by registered fleet vehicles</li>
        </ul>
        <div class="mt-3 p-3 rounded" style="background:white;">
          <p class="mb-1"><strong>Certified By:</strong> FuelReceiptPro System</p>
          <p class="mb-1"><strong>Report ID:</strong> VAT-C001-202606</p>
          <p class="mb-0"><strong>Generated:</strong> 2026-07-01 12:00:00</p>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- ==================== ADMIN PANEL ==================== -->
<div id="admin" class="page">
  <div class="container py-4">
    <h2 class="fw-bold mb-4">⚙️ Admin Panel</h2>
    <div class="row">
      <div class="col-md-6">
        <div class="card">
          <div class="card-header"><h5 class="fw-bold mb-0">🏢 Registered Companies</h5></div>
          <div class="card-body">
            <div style="overflow-x:auto;">
              <table class="table table-sm" id="adminCompanies"></table>
            </div>
          </div>
        </div>
        <div class="card mt-4">
          <div class="card-header"><h5 class="fw-bold mb-0">➕ Add New Company</h5></div>
          <div class="card-body">
            <form onsubmit="return addCompany(event)">
              <div class="mb-3"><label class="form-label" style="color:#333;">Company Name</label><input type="text" class="form-control" id="newCompName" style="background:white;color:#333;border:1px solid #ddd;" required></div>
              <div class="mb-3"><label class="form-label" style="color:#333;">VAT TRN Number</label><input type="text" class="form-control" id="newCompVAT" placeholder="e.g. 100123456700003" style="background:white;color:#333;border:1px solid #ddd;" required></div>
              <div class="mb-3"><label class="form-label" style="color:#333;">Email</label><input type="email" class="form-control" id="newCompEmail" style="background:white;color:#333;border:1px solid #ddd;" required></div>
              <div class="mb-3"><label class="form-label" style="color:#333;">Contact Number</label><input type="text" class="form-control" id="newCompContact" style="background:white;color:#333;border:1px solid #ddd;" required></div>
              <button type="submit" class="btn btn-primary">➕ Register Company</button>
            </form>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card">
          <div class="card-header"><h5 class="fw-bold mb-0">🚗 Registered Vehicles</h5></div>
          <div class="card-body">
            <div style="overflow-x:auto;">
              <table class="table table-sm" id="adminVehicles"></table>
            </div>
          </div>
        </div>
        <div class="card mt-4">
          <div class="card-header"><h5 class="fw-bold mb-0">➕ Register New Vehicle</h5></div>
          <div class="card-body">
            <form onsubmit="return addVehicle(event)">
              <div class="mb-3"><label class="form-label" style="color:#333;">Plate Number</label><input type="text" class="form-control" id="newVehPlate" placeholder="e.g. A12345" style="background:white;color:#333;border:1px solid #ddd;" required></div>
              <div class="mb-3"><label class="form-label" style="color:#333;">Vehicle Type</label><input type="text" class="form-control" id="newVehType" placeholder="e.g. Toyota Land Cruiser" style="background:white;color:#333;border:1px solid #ddd;" required></div>
              <div class="mb-3"><label class="form-label" style="color:#333;">Category</label>
                <select class="form-select" id="newVehCategory" style="background:white;color:#333;border:1px solid #ddd;">
                  <option value="SUV">SUV</option><option value="Sedan">Sedan</option><option value="Pickup">Pickup</option><option value="Van">Van</option><option value="Truck">Truck</option>
                </select>
              </div>
              <div class="mb-3"><label class="form-label" style="color:#333;">Company</label>
                <select class="form-select" id="newVehCompany" style="background:white;color:#333;border:1px solid #ddd;"></select>
              </div>
              <div class="mb-3"><label class="form-label" style="color:#333;">Driver Name</label><input type="text" class="form-control" id="newVehDriver" style="background:white;color:#333;border:1px solid #ddd;" required></div>
              <div class="mb-3"><label class="form-label" style="color:#333;">Fuel Type</label>
                <select class="form-select" id="newVehFuel" style="background:white;color:#333;border:1px solid #ddd;">
                  <option value="Special 95">Special 95</option><option value="Super 98">Super 98</option><option value="E-Plus 91">E-Plus 91</option><option value="Diesel">Diesel</option>
                </select>
              </div>
              <button type="submit" class="btn btn-primary">➕ Register Vehicle</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="card mt-4">
      <div class="card-header"><h5 class="fw-bold mb-0">📜 All Transactions</h5></div>
      <div style="overflow-x:auto;">
        <table class="table" id="adminTxnTable">
          <thead><tr><th>ID</th><th>Date</th><th>Vehicle</th><th>Company</th><th>Station</th><th>Fuel</th><th>Liters</th><th>Amount</th><th>VAT</th><th>Total</th><th>Status</th></tr></thead>
          <tbody id="adminTxnBody"></tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<footer>
  <div class="container">
    <p>⛽ FuelReceiptPro — VAT-Compliant Digital Fuel Receipts</p>
    <small>Prototype for ADNOC / ENOC / Emarat Partnership</small>
  </div>
</footer>

<script>
// ==================== DATA ====================
const companies = {
  'C001': { id: 'C001', name: 'Dubai Logistics LLC', vat_number: '100123456700003', email: 'accounts@dubailogistics.ae', contact: '+971 4 123 4567', vehicles: ['A12345','B67890','C11111'], status: 'active' },
  'C002': { id: 'C002', name: 'Fast Delivery FZCO', vat_number: '100987654300003', email: 'finance@fastdelivery.ae', contact: '+971 4 987 6543', vehicles: ['D22222','E33333'], status: 'active' }
};

const vehicles = {
  'A12345': { plate: 'A12345', type: 'Toyota Land Cruiser', category: 'SUV', company_id: 'C001', driver_name: 'Ahmed Hassan', fuel_type: 'Special 95', status: 'active' },
  'B67890': { plate: 'B67890', type: 'Nissan Patrol', category: 'SUV', company_id: 'C001', driver_name: 'Mohammed Ali', fuel_type: 'Super 98', status: 'active' },
  'C11111': { plate: 'C11111', type: 'Toyota Hilux', category: 'Pickup', company_id: 'C001', driver_name: 'Khalid Omar', fuel_type: 'Diesel', status: 'active' },
  'D22222': { plate: 'D22222', type: 'Mercedes Sprinter', category: 'Van', company_id: 'C002', driver_name: 'Saeed Ibrahim', fuel_type: 'Diesel', status: 'active' },
  'E33333': { plate: 'E33333', type: 'Toyota Corolla', category: 'Sedan', company_id: 'C002', driver_name: 'Yusuf Karim', fuel_type: 'Special 95', status: 'active' }
};

let transactions = [
  { id: 'TXN001', plate: 'A12345', company_id: 'C001', station: 'ADNOC - Sheikh Zayed Road', fuel_type: 'Special 95', liters: 45.5, price_per_liter: 2.92, amount: 132.86, vat_amount: 6.64, total_amount: 139.50, payment_method: 'Card', timestamp: '2026-06-28 08:30:00', cashier: 'cashier1', status: 'completed', receipt_sent: true },
  { id: 'TXN002', plate: 'B67890', company_id: 'C001', station: 'ADNOC - Al Khail Road', fuel_type: 'Super 98', liters: 38.0, price_per_liter: 3.05, amount: 115.90, vat_amount: 5.80, total_amount: 121.70, payment_method: 'Cash', timestamp: '2026-06-29 14:15:00', cashier: 'cashier1', status: 'completed', receipt_sent: true },
  { id: 'TXN003', plate: 'D22222', company_id: 'C002', station: 'ADNOC - Jebel Ali', fuel_type: 'Diesel', liters: 65.0, price_per_liter: 2.75, amount: 178.75, vat_amount: 8.94, total_amount: 187.69, payment_method: 'Card', timestamp: '2026-06-30 09:45:00', cashier: 'cashier1', status: 'completed', receipt_sent: true }
];

let currentVehicle = null;
let currentCompany = 'C001';

function showPage(pageId) {
  document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
  document.getElementById(pageId).classList.add('active');
  window.scrollTo(0, 0);
  if (pageId === 'pos') renderPOS();
  if (pageId === 'dashboard') renderDashboard();
  if (pageId === 'vat_report') renderVATReport();
  if (pageId === 'admin') renderAdmin();
}

function flash(msg, type) {
  const div = document.createElement('div');
  div.className = 'alert alert-' + type;
  div.innerHTML = (type === 'success' ? '✅ ' : '⚠️ ') + msg;
  document.getElementById('flashMessages').appendChild(div);
  setTimeout(() => div.remove(), 4000);
}

function renderPOS() {
  const tbody = document.getElementById('posTxnBody');
  tbody.innerHTML = transactions.slice().reverse().map(txn => {
    const time = txn.timestamp.split(' ')[1];
    const payIcon = txn.payment_method === 'Card' ? '💳' : '💵';
    return '<tr><td><span class="fw-bold text-primary">' + txn.id + '</span></td><td><small>' + time + '</small></td><td><span class="badge badge-dark">' + txn.plate + '</span></td><td>' + txn.fuel_type + '</td><td>' + txn.liters + ' L</td><td>AED ' + txn.amount.toFixed(2) + '</td><td><span class="badge-vat">AED ' + txn.vat_amount.toFixed(2) + '</span></td><td class="fw-bold">AED ' + txn.total_amount.toFixed(2) + '</td><td>' + payIcon + ' ' + txn.payment_method + '</td><td><span class="badge badge-success">' + txn.status + '</span></td><td><a href="#" class="btn btn-sm btn-outline-primary" onclick="viewReceipt('' + txn.id + '')">👁️ View</a></td></tr>';
  }).join('');

  const grid = document.getElementById('posVehicleGrid');
  grid.innerHTML = Object.values(vehicles).map(v =>
    '<div class="col-md-4"><div class="vehicle-card p-3 bg-light rounded"><div class="d-flex justify-content-between align-items-start"><div><h6 class="fw-bold mb-1">' + v.plate + '</h6><p class="text-muted mb-0 small">' + v.type + '</p><p class="text-muted mb-0 small">👤 ' + v.driver_name + '</p></div><span class="badge badge-primary">' + v.fuel_type + '</span></div><div class="mt-2"><small class="text-muted">Company ID: ' + v.company_id + '</small></div></div></div>'
  ).join('');

  document.getElementById('posStatCount').textContent = transactions.length;
  document.getElementById('posStatLiters').textContent = Math.round(transactions.reduce((s,t) => s + t.liters, 0));
  document.getElementById('posStatRevenue').textContent = Math.round(transactions.reduce((s,t) => s + t.total_amount, 0));
  document.getElementById('posStatSent').textContent = transactions.filter(t => t.receipt_sent).length;
}

function lookupVehicle() {
  const plate = document.getElementById('plateInput').value.toUpperCase().trim();
  const infoDiv = document.getElementById('vehicleInfo');
  currentVehicle = vehicles[plate] || null;

  if (currentVehicle) {
    document.getElementById('dispPlate').textContent = plate;
    document.getElementById('dispVehicle').textContent = currentVehicle.type;
    document.getElementById('dispCompany').textContent = companies[currentVehicle.company_id].name;
    document.getElementById('dispFuelType').textContent = currentVehicle.fuel_type;
    const fuelSelect = document.getElementById('fuelType');
    for (let opt of fuelSelect.options) {
      if (opt.value === currentVehicle.fuel_type) { fuelSelect.value = currentVehicle.fuel_type; break; }
    }
    infoDiv.innerHTML = '<span style="color:#4caf50;">✅ Found: ' + currentVehicle.type + ' — ' + currentVehicle.driver_name + '</span>';
    calculateTotal();
  } else {
    document.getElementById('dispPlate').textContent = plate || '---';
    document.getElementById('dispVehicle').textContent = '---';
    document.getElementById('dispCompany').textContent = '---';
    document.getElementById('dispFuelType').textContent = '---';
    if (plate.length >= 3) infoDiv.innerHTML = '<span style="color:#FF9800;">⚠️ Vehicle not registered</span>';
    else infoDiv.innerHTML = '';
  }
  validateForm();
}

function calculateTotal() {
  const fuelSelect = document.getElementById('fuelType');
  const liters = parseFloat(document.getElementById('litersInput').value) || 0;
  const selected = fuelSelect.options[fuelSelect.selectedIndex];
  const price = selected ? parseFloat(selected.dataset.price || 0) : 0;
  const amount = liters * price;
  const vat = amount * 0.05;
  const total = amount + vat;
  document.getElementById('dispLiters').textContent = liters.toFixed(2) + ' L';
  document.getElementById('dispAmount').textContent = 'AED ' + amount.toFixed(2);
  document.getElementById('dispVAT').textContent = 'AED ' + vat.toFixed(2);
  document.getElementById('dispTotal').textContent = 'AED ' + total.toFixed(2);
  validateForm();
}

function validateForm() {
  const plate = document.getElementById('plateInput').value.trim();
  const fuel = document.getElementById('fuelType').value;
  const liters = parseFloat(document.getElementById('litersInput').value) || 0;
  document.getElementById('submitBtn').disabled = !(plate && fuel && liters > 0 && currentVehicle);
}

function submitTransaction(e) {
  e.preventDefault();
  const plate = document.getElementById('plateInput').value.toUpperCase().trim();
  const fuelType = document.getElementById('fuelType').value;
  const liters = parseFloat(document.getElementById('litersInput').value);
  const payment = document.getElementById('paymentMethod').value;
  const vehicle = vehicles[plate];
  const company = companies[vehicle.company_id];

  const price = parseFloat(document.getElementById('fuelType').options[document.getElementById('fuelType').selectedIndex].dataset.price);
  const amount = Math.round(liters * price * 100) / 100;
  const vat = Math.round(amount * 0.05 * 100) / 100;
  const total = Math.round((amount + vat) * 100) / 100;

  const txnId = 'TXN' + String(transactions.length + 1).padStart(3, '0');
  const now = new Date();
  const ts = now.getFullYear() + '-' + String(now.getMonth()+1).padStart(2,'0') + '-' + String(now.getDate()).padStart(2,'0') + ' ' + String(now.getHours()).padStart(2,'0') + ':' + String(now.getMinutes()).padStart(2,'0') + ':' + String(now.getSeconds()).padStart(2,'0');

  transactions.push({
    id: txnId, plate: plate, company_id: vehicle.company_id,
    station: 'ADNOC - Sheikh Zayed Road', fuel_type: fuelType,
    liters: liters, price_per_liter: price, amount: amount,
    vat_amount: vat, total_amount: total, payment_method: payment,
    timestamp: ts, cashier: 'cashier1', status: 'completed', receipt_sent: true
  });

  flash('Transaction ' + txnId + ' completed! Receipt sent to ' + company.email, 'success');
  viewReceipt(txnId);
  return false;
}

function viewReceipt(txnId) {
  const txn = transactions.find(t => t.id === txnId);
  if (!txn) return;
  const vehicle = vehicles[txn.plate];
  const company = companies[txn.company_id];

  document.getElementById('receiptContent').innerHTML =
    '<div class="receipt-paper shadow"><div style="text-align:center;margin-bottom:12px;"><div style="font-size:2rem;color:#00A86B;">⛽</div><h4 style="font-weight:bold;margin-top:8px;margin-bottom:0;">ADNOC</h4><small style="color:#6c757d;">' + txn.station + '</small></div>' +
    '<div style="text-align:center;margin-bottom:12px;"><span class="badge badge-dark">' + txn.id + '</span></div><hr>' +
    '<div class="d-flex justify-content-between small mb-1"><span style="color:#6c757d;">Date:</span><span class="fw-bold">' + txn.timestamp.split(' ')[0] + '</span></div>' +
    '<div class="d-flex justify-content-between small mb-1"><span style="color:#6c757d;">Time:</span><span class="fw-bold">' + txn.timestamp.split(' ')[1] + '</span></div>' +
    '<div class="d-flex justify-content-between small mb-1"><span style="color:#6c757d;">Vehicle Plate:</span><span class="fw-bold">' + txn.plate + '</span></div>' +
    '<div class="d-flex justify-content-between small mb-1"><span style="color:#6c757d;">Vehicle:</span><span class="fw-bold">' + vehicle.type + '</span></div>' +
    '<div class="d-flex justify-content-between small mb-1"><span style="color:#6c757d;">Driver:</span><span class="fw-bold">' + vehicle.driver_name + '</span></div>' +
    '<div class="d-flex justify-content-between small mb-1"><span style="color:#6c757d;">Company:</span><span class="fw-bold">' + company.name + '</span></div>' +
    '<div class="d-flex justify-content-between small mb-1"><span style="color:#6c757d;">VAT TRN:</span><span class="fw-bold">' + company.vat_number + '</span></div><hr>' +
    '<div class="d-flex justify-content-between mb-1"><span>' + txn.fuel_type + '</span><span class="fw-bold">' + txn.liters + ' L</span></div>' +
    '<div class="d-flex justify-content-between mb-1"><span style="color:#6c757d;">@ AED ' + txn.price_per_liter.toFixed(2) + '/L</span><span>AED ' + txn.amount.toFixed(2) + '</span></div><hr>' +
    '<div class="d-flex justify-content-between mb-1"><span>Subtotal:</span><span class="fw-bold">AED ' + txn.amount.toFixed(2) + '</span></div>' +
    '<div class="d-flex justify-content-between mb-1"><span>VAT (5%):</span><span class="fw-bold">AED ' + txn.vat_amount.toFixed(2) + '</span></div>' +
    '<div class="d-flex justify-content-between fs-5 mt-2 pt-2 border-top"><span class="fw-bold">TOTAL:</span><span class="fw-bold text-success">AED ' + txn.total_amount.toFixed(2) + '</span></div><hr>' +
    '<div class="d-flex justify-content-between small"><span style="color:#6c757d;">Payment:</span><span class="fw-bold">' + (txn.payment_method === 'Card' ? '💳' : '💵') + ' ' + txn.payment_method + '</span></div>' +
    '<div class="d-flex justify-content-between small"><span style="color:#6c757d;">Cashier:</span><span class="fw-bold">' + txn.cashier + '</span></div><hr>' +
    '<div style="text-align:center;"><small style="color:#6c757d;">✅ Receipt auto-sent to company</small></div>' +
    '<div style="text-align:center;margin-top:4px;"><small style="color:#006341;">' + company.email + '</small></div></div>';

  document.getElementById('emailPreview').innerHTML =
    '<div class="email-preview"><div class="email-header"><div class="d-flex justify-content-between"><span><strong>From:</strong> receipts@adnoc.ae</span><span style="color:#6c757d;font-size:0.85rem;">' + txn.timestamp + '</span></div><div><strong>To:</strong> ' + company.email + '</div><div><strong>Subject:</strong> 🧾 Fuel Receipt — ' + txn.plate + ' | ' + txn.timestamp.split(' ')[0] + '</div></div>' +
    '<div><p>Hello ' + company.name + ',</p><p>A fuel transaction has been completed for your registered vehicle. Your digital receipt is attached and summarized below:</p>' +
    '<div class="card mt-3 mb-3" style="border:1px solid #dee2e6;padding:16px;"><div class="row"><div class="col-md-6"><p class="mb-1"><strong>Vehicle:</strong> ' + txn.plate + '</p><p class="mb-1"><strong>Driver:</strong> ' + vehicle.driver_name + '</p><p class="mb-1"><strong>Station:</strong> ' + txn.station + '</p></div><div class="col-md-6 text-end"><p class="mb-1"><strong>' + txn.fuel_type + '</strong></p><p class="mb-1">' + txn.liters + ' Liters</p><p class="mb-1">@ AED ' + txn.price_per_liter.toFixed(2) + '/L</p></div></div><hr>' +
    '<div class="d-flex justify-content-between"><span>Subtotal:</span><span>AED ' + txn.amount.toFixed(2) + '</span></div>' +
    '<div class="d-flex justify-content-between"><span>VAT (5%):</span><span>AED ' + txn.vat_amount.toFixed(2) + '</span></div>' +
    '<div class="d-flex justify-content-between fw-bold fs-5 mt-2"><span>Total:</span><span style="color:#00A86B;">AED ' + txn.total_amount.toFixed(2) + '</span></div></div>' +
    '<p style="color:#6c757d;font-size:0.85rem;">This receipt is VAT-compliant and ready for your FTA submission. View all your receipts at your company dashboard.</p>' +
    '<a href="#" class="btn btn-primary btn-sm" onclick="showPage('dashboard')">View Dashboard</a></div></div>';

  document.getElementById('receiptEmail').textContent = company.email;
  showPage('receipt');
}

function renderDashboard() {
  const company = companies[currentCompany];
  const compTxns = transactions.filter(t => t.company_id === currentCompany);
  const compVehicles = Object.values(vehicles).filter(v => v.company_id === currentCompany);

  document.getElementById('dashCompanyName').textContent = company.name;
  document.getElementById('dashVAT').textContent = company.vat_number;
  document.getElementById('dashEmail').textContent = company.email;

  document.getElementById('dashVehicles').textContent = compVehicles.length;
  document.getElementById('dashTxns').textContent = compTxns.length;
  document.getElementById('dashLiters').textContent = Math.round(compTxns.reduce((s,t) => s + t.liters, 0));
  document.getElementById('dashSpent').textContent = Math.round(compTxns.reduce((s,t) => s + t.total_amount, 0));
  document.getElementById('dashTxnCount').textContent = compTxns.length + ' records';

  const totalAmt = compTxns.reduce((s,t) => s + t.amount, 0);
  const totalVAT = compTxns.reduce((s,t) => s + t.vat_amount, 0);
  const totalWithVAT = compTxns.reduce((s,t) => s + t.total_amount, 0);

  document.getElementById('dashExclVAT').textContent = 'AED ' + totalAmt.toFixed(2);
  document.getElementById('dashVATTotal').textContent = 'AED ' + totalVAT.toFixed(2);
  document.getElementById('dashInclVAT').textContent = 'AED ' + totalWithVAT.toFixed(2);

  document.getElementById('dashTxnBody').innerHTML = compTxns.slice().reverse().map(txn =>
    '<tr><td><small style="color:#6c757d;">' + txn.timestamp.split(' ')[0] + '</small><br><small>' + txn.timestamp.split(' ')[1] + '</small></td><td><span class="badge badge-dark">' + txn.plate + '</span></td><td><small>' + txn.station + '</small></td><td>' + txn.fuel_type + '</td><td>' + txn.liters + ' L</td><td>AED ' + txn.amount.toFixed(2) + '</td><td><span class="badge-vat">AED ' + txn.vat_amount.toFixed(2) + '</span></td><td class="fw-bold">AED ' + txn.total_amount.toFixed(2) + '</td></tr>'
  ).join('');

  document.getElementById('dashVehicleList').innerHTML = compVehicles.map(v =>
    '<div class="vehicle-card p-3 mb-3 bg-light rounded"><div class="d-flex justify-content-between align-items-start"><div><h6 class="fw-bold mb-1">' + v.plate + '</h6><p class="text-muted mb-0 small">' + v.type + '</p><p class="text-muted mb-0 small">👤 ' + v.driver_name + '</p></div><span class="badge badge-primary">' + v.fuel_type + '</span></div><div class="mt-2 d-flex justify-content-between"><small class="text-muted">' + v.category + '</small><small style="color:#00A86B;">● Active</small></div></div>'
  ).join('');
}

function exportCSV() {
  const compTxns = transactions.filter(t => t.company_id === currentCompany);
  let csv = 'Transaction ID,Date,Vehicle,Station,Fuel Type,Liters,Amount,VAT,Total,Payment
';
  compTxns.forEach(t => {
    csv += t.id + ',' + t.timestamp + ',' + t.plate + ',' + t.station + ',' + t.fuel_type + ',' + t.liters + ',' + t.amount + ',' + t.vat_amount + ',' + t.total_amount + ',' + t.payment_method + '
';
  });
  const blob = new Blob([csv], {type: 'text/csv'});
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = 'fuel_transactions.csv';
  a.click();
  URL.revokeObjectURL(url);
  flash('CSV exported successfully!', 'success');
}

function renderVATReport() {
  const company = companies[currentCompany];
  const compTxns = transactions.filter(t => t.company_id === currentCompany);

  document.getElementById('vatCompanyName').textContent = company.name;
  document.getElementById('vatCompName').textContent = company.name;
  document.getElementById('vatTRN').textContent = company.vat_number;
  document.getElementById('vatPeriod').textContent = '2026-06';

  const totalAmt = compTxns.reduce((s,t) => s + t.amount, 0);
  const totalVAT = compTxns.reduce((s,t) => s + t.vat_amount, 0);
  const totalWithVAT = compTxns.reduce((s,t) => s + t.total_amount, 0);

  document.getElementById('vatTxnCount').textContent = compTxns.length;
  document.getElementById('vatTaxable').textContent = 'AED ' + totalAmt.toFixed(2);
  document.getElementById('vatAmount').textContent = 'AED ' + totalVAT.toFixed(2);
  document.getElementById('vatGrand').textContent = 'AED ' + totalWithVAT.toFixed(2);

  document.getElementById('vatBody').innerHTML = compTxns.slice().sort((a,b) => a.timestamp.localeCompare(b.timestamp)).map((txn, i) =>
    '<tr><td>' + (i+1) + '</td><td>' + txn.timestamp.split(' ')[0] + '</td><td>' + txn.station + '</td><td>' + txn.fuel_type + ' Fuel</td><td><span class="badge badge-dark">' + txn.plate + '</span></td><td>' + txn.liters + '</td><td>AED ' + txn.price_per_liter.toFixed(2) + '</td><td>AED ' + txn.amount.toFixed(2) + '</td><td><span class="badge-vat">AED ' + txn.vat_amount.toFixed(2) + '</span></td><td class="fw-bold">AED ' + txn.total_amount.toFixed(2) + '</td><td><small style="color:#6c757d;">' + company.vat_number + '</small></td></tr>'
  ).join('');
}

function renderAdmin() {
  const compTable = document.getElementById('adminCompanies');
  compTable.innerHTML = '<thead><tr><th>ID</th><th>Name</th><th>VAT TRN</th><th>Vehicles</th><th>Status</th></tr></thead><tbody>' +
    Object.values(companies).map(c => '<tr><td><span class="badge badge-primary">' + c.id + '</span></td><td>' + c.name + '</td><td><small>' + c.vat_number + '</small></td><td><span class="badge badge-secondary">' + c.vehicles.length + '</span></td><td><span class="badge badge-success">' + c.status + '</span></td></tr>').join('') + '</tbody>';

  const vehTable = document.getElementById('adminVehicles');
  vehTable.innerHTML = '<thead><tr><th>Plate</th><th>Type</th><th>Company</th><th>Driver</th><th>Fuel</th></tr></thead><tbody>' +
    Object.values(vehicles).map(v => '<tr><td><span class="badge badge-dark">' + v.plate + '</span></td><td><small>' + v.type + '</small></td><td><small>' + (companies[v.company_id] ? companies[v.company_id].name : 'N/A') + '</small></td><td><small>' + v.driver_name + '</small></td><td><span class="badge badge-primary">' + v.fuel_type + '</span></td></tr>').join('') + '</tbody>';

  const compSelect = document.getElementById('newVehCompany');
  compSelect.innerHTML = Object.values(companies).map(c => '<option value="' + c.id + '">' + c.name + '</option>').join('');

  document.getElementById('adminTxnBody').innerHTML = transactions.slice().reverse().map(txn =>
    '<tr><td><span class="fw-bold text-primary">' + txn.id + '</span></td><td><small>' + txn.timestamp + '</small></td><td><span class="badge badge-dark">' + txn.plate + '</span></td><td><small>' + (companies[txn.company_id] ? companies[txn.company_id].name : 'N/A') + '</small></td><td><small>' + txn.station + '</small></td><td>' + txn.fuel_type + '</td><td>' + txn.liters + ' L</td><td>AED ' + txn.amount.toFixed(2) + '</td><td><span class="badge-vat">AED ' + txn.vat_amount.toFixed(2) + '</span></td><td class="fw-bold">AED ' + txn.total_amount.toFixed(2) + '</td><td><span class="badge badge-success">' + txn.status + '</span></td></tr>'
  ).join('');
}

function addCompany(e) {
  e.preventDefault();
  const id = 'C' + String(Object.keys(companies).length + 1).padStart(3, '0');
  companies[id] = {
    id: id, name: document.getElementById('newCompName').value,
    vat_number: document.getElementById('newCompVAT').value,
    email: document.getElementById('newCompEmail').value,
    contact: document.getElementById('newCompContact').value,
    vehicles: [], status: 'active'
  };
  flash('Company added successfully!', 'success');
  renderAdmin();
  return false;
}

function addVehicle(e) {
  e.preventDefault();
  const plate = document.getElementById('newVehPlate').value.toUpperCase().trim();
  const cid = document.getElementById('newVehCompany').value;
  vehicles[plate] = {
    plate: plate, type: document.getElementById('newVehType').value,
    category: document.getElementById('newVehCategory').value,
    company_id: cid, driver_name: document.getElementById('newVehDriver').value,
    fuel_type: document.getElementById('newVehFuel').value, status: 'active'
  };
  if (!companies[cid].vehicles.includes(plate)) companies[cid].vehicles.push(plate);
  flash('Vehicle registered successfully!', 'success');
  renderAdmin();
  return false;
}

showPage('home');
</script>
</body>
</html>
